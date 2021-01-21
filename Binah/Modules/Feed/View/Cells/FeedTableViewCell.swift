//
//  FeedTableViewCell.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    var feedCellViewModel: FeedCellViewModel!
    {
        didSet {
            userNameLabel.text = feedCellViewModel?.userDiaplayName
            titleLabel.text = feedCellViewModel?.title
            dateCreatedLabel.text = feedCellViewModel?.dateCreatedString
            viewCountLabel.text = String(feedCellViewModel?.viewCount ?? 0)
            
            feedCellViewModel.userImage.bind({ (image) in
                DispatchQueue.main.async {
                    self.userProfileImage.image = image
                    self.activityIndicator.stopAnimation()
                    self.layoutIfNeeded()
                }
            })
            feedCellViewModel.fetchImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height/2
        userProfileImage.clipsToBounds = true
        userProfileImage.layer.borderWidth = 1
        userProfileImage.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}

extension FeedTableViewCell: CellIdentifiable{}
