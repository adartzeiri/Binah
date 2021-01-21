//
//  NetworkLogger.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

struct NetworkLogger {
    static func log(_ request: URLRequest) {
        print("\n========================= OUTGOING REQUEST =========================")
        defer { print("================================ END ===============================\n") }

        let urlAsString   = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod   ?? ""
        let path   = urlComponents?.path  ?? ""
        let query  = urlComponents?.query ?? ""
        let host   = urlComponents?.host  ?? ""
        
        //Output Variable
        var logOutput =
        """
        Request [\(method)] : \(urlAsString)
        Host:    \(host)
        Params:  \(method) \(path)?\(query) HTTP/1.1 \n
        """
        
        //Add Body Params
        if let body = request.httpBody, let bodyAsString = String(data: body, encoding: .utf8) {
            logOutput += "Body:  \(bodyAsString) \n"
        }
        
        //Add Headers
        logOutput += "Headers: ["
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += ("\n  \(key) : \(value)")
        }
        logOutput += "\n]"

        //Print Output
        print(logOutput)
    }
     
    static func log(_ response: URLResponse?, data: Data?, date: Date?) {
        print("\n========================= INCOMING RESPONSE =========================")
        defer { print("================================ END ===============================\n") }
        
        guard let response = response as? HTTPURLResponse else { return }
        
        let urlAsString   = response.url?.absoluteString ?? ""
        
        let status    = response.statusCode
        let statusDescription = HTTPURLResponse.localizedString(forStatusCode: status)
        let duration  = Date().timeIntervalSince(date ?? Date())
        
        //Output Variable
        var logOutput =
        """
        Response : \(urlAsString)
        Status: \(status) - \(statusDescription)
        Duration: \(duration)\n
        """
        
        //Add Body Params
        //TODO
        
        
        //Add Headers
        logOutput += "Headers: ["
        for (key, value) in response.allHeaderFields {
            logOutput += ("\n  \(key) : \(value)")
        }
        logOutput += "\n]"

        print(logOutput)
    }
}
