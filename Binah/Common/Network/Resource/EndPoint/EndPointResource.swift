//
//  EndPointResource.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

public protocol EndPointResource {
    associatedtype ModelType: Decodable
    
    var baseURL:     URL          { get }
    var path:        String       { get }
    var httpMethod:  HTTPMethod   { get }
    var task:        HTTPTask     { get }
    var params:      HTTPParams?  { get }
    var headers:     HTTPHeaders? { get }
    var sampleData:  Data?        { get }
}

extension EndPointResource {
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var environmentBaseURL : String {
        //Should use Enviorment Base URL
        "https://api.stackexchange.com"
    }
}
