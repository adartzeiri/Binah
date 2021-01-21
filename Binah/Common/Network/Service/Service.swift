//
//  Service.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

public typealias NetworkCompletion<T> = (Result<T,Error>) -> Void
public typealias NetworkCompletionDataResponse = (_ data: Data?,_ response: URLResponse?,_ error: Error?)-> Void
public typealias GenericCompletion = (Any) -> Void

public protocol NetworkService: AnyObject {
    associatedtype Resource
    /// Perform request with 'Result' completion
    /// - Parameter completion: (Result<T,Error>)
    func request(withCompletion completion: @escaping NetworkCompletion<Resource>)
    
    /// Perform request with URLResponse & Data completion
    /// - Parameter completion: (_ data: Data?,_ response: URLResponse?,_ error: Error?)
    func request(withCompletion completion: @escaping NetworkCompletionDataResponse)
    
    //func request(withCompletion completion: @escaping GenericCompletion)
}

extension NetworkService {
    func request(withCompletion completion: @escaping NetworkCompletionDataResponse) {}
    func request(withCompletion completion: @escaping NetworkCompletion<Resource>)   {}
}
