//
//  TSDetailViewModel.swift
//  TechSaga
//
//  Created by  Jain on 23/08/23.
//

import Foundation

class TSDetailViewModel {
    
    private var newsArticleData: NewsArticleModel
    
    init(newsArticleData: NewsArticleModel) {
        self.newsArticleData = newsArticleData
    }
    
    func getArticleData() -> NewsArticleModel {
        newsArticleData
    }
}
