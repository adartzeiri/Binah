//
//  PlaceholderView.swift
//  Binah
//
//  Created by Adar Tzeiri on 20/01/2021.
//

import UIKit

class PlaceholderView: StoryboardCustomXibView {
    @IBOutlet weak var title: UILabel!
    
    var type: TitleCustomization! {
        didSet{
            title.text = type.title
            
            //Further use example
            //title.? = type.?
        }
    }
    
    enum TitleCustomization {
        case noResults
        case loading
        case other(title: String)
        
        var title: String {
            switch self {
            case .noResults: return "Sorry. \nNo questions found.\n Please try again later."
            case .loading: return "Loading..."
            case .other(let title): return title
            }
        }
    }
    
    override func xibName() -> String {
        return "PlaceholderView"
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        type = .loading
    }
}
