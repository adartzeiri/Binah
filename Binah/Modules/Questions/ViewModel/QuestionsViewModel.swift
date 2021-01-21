//
//  QuestionsViewModel.swift
//  Binah
//
//  Created by Adar Tzeiri on 20/01/2021.
//

import Foundation

struct QuestionsViewModel {
    private var linkStringURL: String
    var linkURL : URL? {
        guard let url = URL(string: linkStringURL) else { return nil }
        return url
    }
    
    init(linkStringURL: String) {
        self.linkStringURL = linkStringURL
    }
}
