//
//  Service + Cancelable.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

public protocol Cancelable: AnyObject {
    var task: URLSessionTask? { get set }
    func cancel()
}

extension Cancelable {
    func cancel() {
        task?.cancel()
    }
}
