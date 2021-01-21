//
//  Observable.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

public class Observable<T> {
    typealias Listener = (T) -> ()
    
    var listener : Listener?
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndNotify(_ listener: Listener?) {
        bind(listener)
        listener?(value)
    }
}
