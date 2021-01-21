//
//  NetworkManager.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

struct NetworkManager<Resource: EndPointResource> : Networkable {
    typealias Model = Resource
    
    var task: URLSessionDataTask?
    var service: APIService<Model>
    
    init(resource: Model) {
        self.service = APIService(resource: resource)
    }
}
