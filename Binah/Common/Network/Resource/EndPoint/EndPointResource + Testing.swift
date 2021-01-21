//
//  EndPointResource + Testing.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

func stubbedResponse(_ fileName: String) -> Data! {
    @objc class TestClass : NSObject {}
    
    let bundle = Bundle(for: TestClass.self)
    let path   = bundle.path(forResource: fileName, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
