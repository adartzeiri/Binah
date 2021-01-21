//
//  GenericDataSource.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

class GenericDataSource<T>: NSObject {
    var data : Observable<[T]> = Observable([])
}
