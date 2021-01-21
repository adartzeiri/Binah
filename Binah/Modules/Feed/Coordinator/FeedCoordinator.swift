//
//  FeedCoordinator.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit

class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()

    var navigationContoller: UINavigationController

    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
    
    func start() {
        let feedVC = FeedViewController.instantiate(.Feed)
        feedVC.feedViewModel = FeedViewModel(endPoint: FeedEndPoint())
        feedVC.coordinator = self
        navigationContoller.pushViewController(feedVC, animated: true)
    }
    
    func didSelectQuestion(_ stringURL: String) {
        let questionVC = QuestionsViewContoller.instantiate(.Questions)
        let questionVM = QuestionsViewModel(linkStringURL: stringURL)
        questionVC.questionsViewModel = questionVM
        navigationContoller.pushViewController(questionVC, animated: true)
    }
}
