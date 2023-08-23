//
//  TSHomeViewModel.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation

class TSHomeViewModel {
    
    private var newsArticleData: [NewsArticleModel]?
    
    func getHeadlines(completion: @escaping () -> Void) {
        //Create request
        let request = URLRequestBuilder(endPoint: StringConstants.ApiEndPoint.newsapi).getUrlRequest()
        //Fetching data
        TSNetworkManager().getDataFromServer(urlRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                //Parsing data
                let parser = NewsAPIParser(decoder: JSONDecoder())
                if let newsModel = parser.parse(data: data), let articles = newsModel.articles {
                    //Save to Core data
                    TSHeadlinesDataRepository().saveHeadlinesData(articles)
                    self.newsArticleData = articles
                } else {
                    //Fetch from Core data in case of any error
                    self.newsArticleData = TSHeadlinesDataRepository().getHeadlinesData()
                }
                completion()
            case .failure(_):
                //Fetch from Core data in case of any error
                self.newsArticleData = TSHeadlinesDataRepository().getHeadlinesData()
                completion()
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        newsArticleData?.count ?? 0
    }
    
    func getDataAt(_ indexPath: IndexPath) -> NewsArticleModel? {
        newsArticleData?[indexPath.row]
    }
}
