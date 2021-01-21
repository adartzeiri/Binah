//
//  ApplicationCoordinator.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit

class ApplicationCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationContoller: UINavigationController
    
    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
    
    func start() {
        navigationContoller.delegate = self
        let feedCoordinator = FeedCoordinator(navigationContoller: navigationContoller)
        childCoordinators.append(feedCoordinator)
        feedCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if  coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let feedViewController = fromViewController as? FeedViewController {
            childDidFinish(feedViewController.coordinator)
        }
    }
}
