//
//  TSNewsRepo.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation

protocol TSHeadlinesRepository {
    func clearRecords()
    func saveHeadlinesData(_ articles: [NewsArticleModel])
    func getHeadlinesData() -> [NewsArticleModel]?
}

struct TSHeadlinesDataRepository: TSHeadlinesRepository {
    
    func saveHeadlinesData(_ articles: [NewsArticleModel]) {
        if let newsEntity = TSNewsEntity.insertNewObject() as? TSNewsEntity {
            newsEntity.data = try? JSONEncoder().encode(articles)
            TSNewsEntity.saveRecords()
        }
    }
    
    func getHeadlinesData() -> [NewsArticleModel]? {
        if let newsEntity = (TSNewsEntity.getObjectPredicate(nil, sort: nil, onMainQueue: false)?.first) as? TSNewsEntity {
            if let data = newsEntity.data as? Data, let articleModel = try? JSONDecoder().decode([NewsArticleModel].self, from: data)  {
                return articleModel
            }
        }
        return nil
    }
    
    func clearRecords() {
        if let newsItems = TSNewsEntity.getAllObjects() as? [TSNewsEntity] {
            TSNewsEntity.deleteObjects(newsItems)
            TSNewsEntity.saveRecords()
        }
    }
}
