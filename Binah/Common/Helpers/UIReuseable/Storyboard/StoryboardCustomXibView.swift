//
//  StoryboardCustomXibView.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import UIKit

class StoryboardCustomClearXibView: StoryboardCustomXibView {
    
    // When we drag an object onto a storyboard and configure it, Interface Builder serializes the state of that object on to disk, then deserialize it when the storyboard appears on screen. We need to tell Interface Builder how to do those.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let customChild = subviews.first {
            customChild.backgroundColor = UIColor.clear
        }
    }
}

class StoryboardCustomXibView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let customView = Bundle.main.loadNibNamed(xibName(), owner: self, options: nil)?.first as? UIView {
            backgroundColor = UIColor.clear
            addSubviewWithSameSizeConstraints(customView)
            self.frame = customView.frame
            awakeFromNib()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let customView = Bundle.main.loadNibNamed(xibName(), owner: self, options: nil)?.first as? UIView {
            backgroundColor = UIColor.clear
            addSubviewWithSameSizeConstraints(customView)
        }
    }
   
    func xibName() -> String {
        return String(describing: self)
    }
}
