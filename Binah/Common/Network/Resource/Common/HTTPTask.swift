//
//  HTTPTask.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

public typealias HTTPHeaders = [String:String]
public typealias HTTPParams  = [String:Any]

public enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
