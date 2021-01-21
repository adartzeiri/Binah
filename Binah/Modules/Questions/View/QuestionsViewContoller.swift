//
//  QuestionsViewContoller.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit
import WebKit

class QuestionsViewContoller: UIViewController, Storyboarded, Loadable {
    var activityIndicatorView: UIActivityIndicatorView!
    var questionsViewModel : QuestionsViewModel?
    
    private var webView    : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initializeLargeActivityIndicator(.black)
    }
    
    private func setupViews() {
        title = "Question"
        setWebView()
    }
    
    private func setWebView() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        webView = WKWebView(frame: .zero)
        webView.allowsLinkPreview   = false
        webView.navigationDelegate  = self
        view.addSubviewWithSameSizeConstraints(webView)
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
      
        loadHome()
    }
    
    private func loadHome() {
        guard let url = questionsViewModel?.linkURL else { return }
        webView.load(URLRequest(url: url))
    }
}

extension QuestionsViewContoller: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideIndicator()
    }
}
