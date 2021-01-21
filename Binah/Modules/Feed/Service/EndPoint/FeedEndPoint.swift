//
//  FeedEndPoint.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import Foundation

struct FeedEndPoint: EndPointResource {
    var baseURL: URL = URL(string: "https://api.stackexchange.com/2.2/questions?order=desc&sort=creation&site=stackoverflow")!
    
    var path: String = "" 
    
    var httpMethod: HTTPMethod { .get }
    
    var task: HTTPTask { .request }
    
    var params: HTTPParams? { nil }
    
    var headers: HTTPHeaders? { nil }
    
    var sampleData: Data? { stubbedResponse("Feed") }
    
    typealias ModelType = FeedModelWrapper
}
