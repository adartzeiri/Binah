//
//  Storyboarded.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit

protocol Storyboarded {
    static func instantiate(_ storyboard: Storyboard) -> Self
}

enum Storyboard : String {
    case Feed
    case Questions
}

extension Storyboarded where Self : UIViewController {
    static func instantiate(_ storyboard: Storyboard) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
