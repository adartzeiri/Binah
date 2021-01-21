//
//  Loadable.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//


import UIKit

protocol Loadable: class
{
    //MARK: - Properties
    var activityIndicatorView: UIActivityIndicatorView! {get set}
    
    //MARK: - Activity indicator load logic
    func initializeActivityIndicator()
    func initializeLargeActivityIndicator(_ color: UIColor)
    func showIndicator()
    func hideIndicator()
}

extension Loadable where Self: UIViewController
{
    ///Implement before calling other methods
    func initializeActivityIndicator()
    {
        activityIndicatorView = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.medium)
        activityIndicatorView.hidesWhenStopped = true
        
        UIView.addCenterConstraints(for: activityIndicatorView, to: view)
        showIndicator()
    }
    
    func initializeLargeActivityIndicator(_ color: UIColor = .white) {
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = color
        UIView.addCenterConstraints(for: activityIndicatorView, to: view)
        showIndicator()
    }
    
    func showIndicator()
    {
        guard let activityIndicatorView = activityIndicatorView else { fatalError("Call configureActivityIndicator in viewDidLoad") }
        activityIndicatorView.startAnimating()
        view.bringSubviewToFront(activityIndicatorView)
    }
    
    func hideIndicator()
    {
        guard let activityIndicatorView = activityIndicatorView else { fatalError("Call configureActivityIndicator in viewDidLoad") }
        activityIndicatorView.stopAnimating()
    }
}
