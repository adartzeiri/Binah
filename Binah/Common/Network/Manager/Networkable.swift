//
//  Networkable.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

protocol Networkable {
    associatedtype Model : EndPointResource
    typealias Service = APIService<Model>
    
    var service : Service { get set }
    var task    : URLSessionDataTask? { get set }
}
