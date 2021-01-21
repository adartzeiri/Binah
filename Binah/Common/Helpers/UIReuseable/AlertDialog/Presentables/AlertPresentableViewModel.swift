//
//  AlertPresentableViewModel.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import Foundation

protocol AlertPresentableViewModel {
    var alertModel: Observable<AlertModel?> { get set }
}
