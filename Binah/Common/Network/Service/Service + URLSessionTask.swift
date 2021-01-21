//
//  Service + URLSessionTask.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation
import UIKit.UIImage

public protocol URLSessionTaskProtocol: NetworkService, Cancelable, Progressible {
    /// Returns Result<Success, Failure> from Data
    /// - Parameter data: Data object received from service call
    func decode(_ data: Data) -> Result<Resource,Error>
    
    //TODO add stubRequest
}

//MARK: - Default Implementation
fileprivate extension URLSessionTaskProtocol {
    func load(_ request: URLRequest, withCompletion completion: @escaping NetworkCompletion<Resource>){
        let logDuration = Date()
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            NetworkLogger.log(response, data: data, date: logDuration)
            guard let self = self  else { return }
            guard let data = data else {
                completion(.failure(NetworkError.encodingFailed))
                return
            }
            do {
                let decodedData = try self.decode(data).get()
                completion(.success(decodedData))
                self.stopObserving()
            } catch {
                completion(.failure(error))
            }
        })
        startObserving()
        task?.resume()
    }
    
    func load(_ request: URLRequest, withCompletion completion: @escaping NetworkCompletionDataResponse) {
        let logDuration = Date()
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            NetworkLogger.log(response, data: data, date: logDuration)
            guard self != nil  else { return }
            guard let data = data else {
                completion(nil, response, error)
                return
            }
            completion(data, response, nil)
        })
        startObserving()
        task?.resume()
    }
}


//MARK: - API Service
class APIService<Resource: EndPointResource>: URLSessionTaskProtocol, Progressible {
    private let resource: Resource
    var observation: NSKeyValueObservation?
    var progressCompletion: Observable<Int>?
    var task: URLSessionTask?
    
    init(resource: Resource) {
        self.resource = resource
    }
    
    convenience init(resource: Resource, observeProgress : Bool) {
        self.init(resource: resource)
        if observeProgress {
            progressCompletion = Observable(0)
        }
    }
    
    deinit {
        observation?.invalidate()
    }
}

extension APIService {
    func request(withCompletion completion: @escaping NetworkCompletionDataResponse) {
        do {
            let request = try self.buildRequest()
            NetworkLogger.log(request)
            load(request, withCompletion: completion)
        }catch {
            completion(nil, nil, error)
        }
    }
    
    func request(withCompletion completion: @escaping NetworkCompletion<Resource.ModelType>) {
        do {
            let request = try self.buildRequest()
            NetworkLogger.log(request)
            load(request, withCompletion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func decode(_ data: Data) -> Result<Resource.ModelType, Error> {
        do {
            let wrapper = try JSONDecoder().decode(Resource.ModelType.self, from: data)
            return .success(wrapper)
        } catch {
            return .failure(error)
        }
    }
}


//MARK: - UIImage Service
class ImageService: URLSessionTaskProtocol, Progressible {
    var observation: NSKeyValueObservation?
    var progressCompletion: Observable<Int>?
    
    var task: URLSessionTask?
    
    private let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    convenience init(_ url: URL, observeProgress : Bool) {
        self.init(url)
        
        if observeProgress {
            progressCompletion = Observable(0)
        }
    }
    
    deinit {
        observation?.invalidate()
    }
}

extension ImageService {
    func request(withCompletion completion: @escaping NetworkCompletion<UIImage>) {
        load(URLRequest(url: url), withCompletion: completion)
    }
    
    func decode(_ data: Data) -> Result<UIImage, Error> {
        guard let image = UIImage(data: data) else {
            return .failure(NetworkError.parserFailed)
        }
        return .success(image)
    }
}



//MARK: - Private Utils Func
private extension APIService {
    func buildRequest() throws -> URLRequest {
        
        var request = URLRequest(url: resource.baseURL.appendingPathComponent(resource.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = resource.httpMethod.rawValue
        do {
            switch resource.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
