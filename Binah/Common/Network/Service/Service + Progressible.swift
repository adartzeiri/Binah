//
//  Service + Progressible.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

public protocol Progressible: AnyObject {
    var observation: NSKeyValueObservation? { get set }
    var progressCompletion: Observable<Int>? { get set }
    var task: URLSessionTask? { get set }
    func startObserving()
    func stopObserving()
}

extension Progressible {
    func startObserving() {
        observation = task?.progress.observe(\.fractionCompleted, changeHandler: { progress, _ in
            self.progressCompletion?.value = Int(progress.fractionCompleted * 100)
        })
    }
    
    func stopObserving() {
        observation = nil
    }
}
