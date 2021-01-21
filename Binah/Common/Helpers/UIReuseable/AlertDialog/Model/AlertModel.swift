//
//  AlertModel.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import UIKit

struct AlertModel {
    struct ActionModel {
        var title: String?
        var style: UIAlertAction.Style
        var handler: ((UIAlertAction) -> ())?
    }
    
    var actionModels = [ActionModel]()
    var title: String?
    var message: String?
    var prefferedStyle: UIAlertController.Style
}

class AlertBuilder {
    static func buildAlertController(for model: AlertModel) -> UIAlertController {
        let controller = UIAlertController(title: model.title, message: model.message, preferredStyle: model.prefferedStyle)
        
        model.actionModels.forEach({ controller.addAction(UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler)) })
        
        return controller
    }
}
