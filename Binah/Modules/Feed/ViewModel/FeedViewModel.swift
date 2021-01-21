//
//  FeedViewModel.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import Foundation

protocol FeedViewModelable: AlertPresentableViewModel {
    associatedtype EndPoint : EndPointResource
    
    var dataSource: FeedTableDataSource           { get }
    var networkManager: NetworkManager<EndPoint>? { get }
    var alertModel: Observable<AlertModel?>       { get set }
    var feedFilterType: FeedsFilterType           { get set }
    var feedCellViewModels: [FeedCellViewModel]   { get set }
    var isLoading: Observable<Bool>               { get set }
    var updateNoResultsFound: Observable<Bool>    { get set }
    
    func fetchFeed()
    func filterDidChange(type: FeedsFilterType)
}

class FeedViewModel: FeedViewModelable {
    typealias EndPoint = FeedEndPoint
    
    var networkManager: NetworkManager<EndPoint>?
    var alertModel: Observable<AlertModel?> = Observable(nil)
    var dataSource: FeedTableDataSource = FeedTableDataSource()
    var feedCellViewModels: [FeedCellViewModel] = []
    var isLoading: Observable<Bool> = Observable(true)
    var feedFilterType: FeedsFilterType = .answered
    var updateNoResultsFound: Observable<Bool> = Observable(false)
    
    convenience init(endPoint: EndPoint) {
        self.init()
        self.networkManager = NetworkManager(resource: endPoint)
    }
    
    func fetchFeed() {
        isLoading.value = true
        networkManager?.service.request(withCompletion: { [weak self] (result) in
            self?.isLoading.value = false
            switch result {
            case .failure(_ ):
                self?.alertModel.value = AlertModel(actionModels: [.init(title: "Retry", style: .default, handler: { (action) in
                    self?.fetchFeed()
                })], title: "Oops", message: "Something happened", prefferedStyle: .alert)
            case .success(let feedWrapper):
                self?.feedCellViewModels = feedWrapper.feedModels?.map({FeedCellViewModel(userDiaplayName: $0.owner?.display_name, userImageUrlString: $0.owner?.profile_image, title: $0.title, viewCount: $0.view_count, dateCreated: $0.creation_date, link: $0.link, isAnswered: $0.is_answered)}) ?? []
                
                
                guard self?.validateResults() ?? false
                else { self?.updateNoResultsFound.value = true; return }
                self?.dataSource.data.value = self?.getFilteredResults() ?? []
            }
        })
    }
    
    func filterDidChange(type: FeedsFilterType) {
        feedFilterType = type
        
        guard self.validateResults() else { updateNoResultsFound.value = true; return }
        updateNoResultsFound.value = false
        dataSource.data.value = getFilteredResults()
    }
    
    private func getFilteredResults() -> [FeedCellViewModel] {
        feedCellViewModels.filter({$0.isAnswered == feedFilterType.isAnswered})
    }
    
    private func validateResults() -> Bool {
        !getFilteredResults().isEmpty
    }
}

enum FeedsFilterType: Int {
    case answered    = 0
    case unanswered  = 1
    
    var isAnswered: Bool {
        switch self {
        case .answered:   return true
        case .unanswered: return false
        }
    }
}
