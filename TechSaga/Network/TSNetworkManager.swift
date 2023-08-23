//
//  TSNetworkManager.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import UIKit

//MARK: StringConstants

struct StringConstants {
    
    //API Endpoint on which we request
    struct ApiEndPoint {
        static let newsapi = "https://newsapi.org/v2/everything?q=tesla&from=2023-07-22&sortBy=publishedAt&apiKey=729d59614d924bdf9359d10a9857f718"
    }
    
    //Date Format
    struct DateFormat {
        static let yy_MM_dd_hh_ss = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        static let yy_MM_dd = "yyyy-MM-dd"
    }
}

struct URLRequestBuilder {
    
    //MARK: Properties
    
    private let endPoint: String
    
    //MARK: Initializer
    
    init(endPoint: String) {
        self.endPoint = endPoint
    }
    
    //MARK: Internal Method
    
    //Create url request with endpoint
    func getUrlRequest() -> URLRequest? {
        guard let url = URL(string: endPoint) else { return nil }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        return request
    }
}

struct NewsAPIParser {
    
    //MARK: Properties
    
    private let decoder: JSONDecoder
    
    //MARK: Initializer
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    //MARK: Internal Method
    
    //Decode data to Model
    func parse(data: Data) -> NewsModel? {
        return (try? decoder.decode(NewsModel.self, from: data))
    }
}

struct TSNetworkManager {
    
    //MARK: Properties
    
    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)
    
    //MARK: Internal Methods
    
    //Get data with url request
    func getDataFromServer(urlRequest: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = urlRequest else { return }
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

