//
//  AlertPresentableViewController.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import UIKit

protocol AlertPresentableView {
    var alertViewModel: AlertPresentableViewModel? { get set }
}

extension AlertPresentableView where Self: UIViewController {
    func bindToAlerts() {
        alertViewModel?.alertModel.bind { [weak self] (alertModel) in
            guard let alertModel = alertModel else { return }
            let alertVC = AlertBuilder.buildAlertController(for: alertModel)
            self?.present(alertVC, animated: true, completion: nil)
        }
    }
}
