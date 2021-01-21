//
//  Coordinator.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators : [Coordinator] { get set }
    var navigationContoller: UINavigationController { get set }
    
    func start()
}
