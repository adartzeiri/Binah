//
//  FeedViewController.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import UIKit

class FeedViewController: UIViewController, Storyboarded, Loadable, AlertPresentableView {
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var filterByLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderView: PlaceholderView!
    
    private var shouldAnimate = true
    private var allowRefresh = true
    
    private let refreshControl = UIRefreshControl()
    var viewModels: [FeedCellViewModel] = []
    var feedViewModel: FeedViewModel? {
        didSet {
            alertViewModel = feedViewModel
        }
    }
    
    weak var coordinator: FeedCoordinator?
    
    var alertViewModel: AlertPresentableViewModel?
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if self.tableView.window != nil {
//            print("visible")
//        } else {
//            print("Not Visible")
//        }
        setupViews()
        bindViewModel()
        feedViewModel?.fetchFeed()
        bindToAlerts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimationIfNeeded()
    }
    
    private func setupViews() {
        title = "Answered"
        navigationController?.navigationBar.barTintColor = .white
        
        tableView.register(FeedTableViewCell.cellNib, forCellReuseIdentifier: FeedTableViewCell.cellID)
        tableView.delegate   = self
        
        placeholderView.configure()
        handlePlacholderStateWith(type: .loading, isVisibile: true)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        initializeLargeActivityIndicator()
    }
    
    private func bindViewModel() {
        feedViewModel?.updateNoResultsFound.bind({ [weak self] (isEmpty) in
            self?.handlePlacholderStateWith(type: .noResults, isVisibile: isEmpty)
        })
        
        feedViewModel?.dataSource.data.bind({ [weak self] _ in
            self?.tableView.dataSource = self?.feedViewModel?.dataSource
            self?.tableView.reloadData()
        })
        
        feedViewModel?.isLoading.bindAndNotify({ [weak self] (isLoading) in
            self?.finishRefresh()
            isLoading ? self?.showIndicator() : self?.hideIndicator()
        })
    }
    
    // MARK: - PlacholderView
    func handlePlacholderStateWith(type: PlaceholderView.TitleCustomization?, isVisibile: Bool) {
        self.placeholderView.isHidden = !isVisibile
        guard type != nil else { return }
        self.placeholderView.type = type
        self.view.layoutIfNeeded()
    }
    
    
    func performAnimationIfNeeded() {
        if shouldAnimate {
            shouldAnimate = false
            UIView.transition(with: filterByLabel, duration: 0.9, options: .transitionCrossDissolve, animations: {
                self.filterByLabel.font = UIFont.systemFont(ofSize: 25)
                self.view.layoutIfNeeded()
            }) { isFinished in
                UIView.transition(with: self.filterByLabel, duration: 0.9, options: .transitionCrossDissolve, animations: {
                    self.filterByLabel.font = UIFont.systemFont(ofSize: 16)
                    self.view.layoutIfNeeded()
                }) { isFinished in}
            }
        }
    }
    
    @objc private func refreshData(_ refreshControl: UIRefreshControl) {
         if allowRefresh{
             Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false) { timer in
                 timer.invalidate()
                 self.allowRefresh = true
             }
             allowRefresh = false
            feedViewModel?.fetchFeed()
         }else{
             finishRefresh()
         }
     }
    
    @objc func finishRefresh()
    {
        refreshControl.endRefreshing()
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let filterType = FeedsFilterType(rawValue: sender.selectedSegmentIndex) else { return }
        
        title = filterType == .answered ? "Answered" : "Unanswered" 
        
        feedViewModel?.filterDidChange(type:filterType)
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.didSelectQuestion(feedViewModel?.dataSource.data.value[indexPath.row].link ?? "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 0.35, delay: 0.04 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
