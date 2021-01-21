//
//  Service + Testing.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

extension APIService {
    func requestFake(_ endPoint: Resource, error: Error? = nil , delay: DispatchTime = .now(), withCompletion completion: @escaping NetworkCompletion<Resource.ModelType>) {
        DispatchQueue.global().asyncAfter(deadline: delay) {
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = endPoint.sampleData {
                    do {
                        let value = try JSONDecoder().decode(Resource.ModelType.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
