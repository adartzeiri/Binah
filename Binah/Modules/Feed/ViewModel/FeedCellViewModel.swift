//
//  FeedCellViewModel.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import Foundation
import UIKit.UIImage

class FeedCellViewModel {
    var userDiaplayName:    String?
    var userImageUrlString: String?
    var title:              String?
    var viewCount:          Int?
    var link:               String?
    var isAnswered:         Bool?
    var imageService:       ImageService?
    var userImage:          Observable<UIImage?> = Observable(nil)
    private var dateCreated: Int?
    
    var dateCreatedString: String? {
        guard let epochDate = dateCreated else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        let epochTime = TimeInterval(epochDate) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        
        return dateFormatter.string(from: date)
    }
    
    init(userDiaplayName: String?,
         userImageUrlString: String?,
         title: String?,
         viewCount: Int?,
         dateCreated: Int?,
         link: String?,
         isAnswered: Bool?) {
        self.userDiaplayName = userDiaplayName
        self.userImageUrlString = userImageUrlString
        self.title = title
        self.viewCount = viewCount
        self.dateCreated = dateCreated
        self.link = link
        self.isAnswered = isAnswered
    }
    
    func fetchImage() {
        guard let imageURL = URL(string: userImageUrlString ?? "") else { return }
        imageService = ImageService(imageURL)
        imageService?.request(withCompletion: { [weak self] (result) in
            switch result {
            case . failure( _): break
            case .success(let image):
                self?.userImage.value = image
            }
        })
    }
}
