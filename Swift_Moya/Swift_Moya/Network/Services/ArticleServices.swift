//
//  ArticleServices.swift
//  Swift_Moya
//
//  Created by 이성호 on 2023/06/13.
//

import Foundation
import Moya

enum ArticleServices {
    case fetchArticle(country: String)
}

extension ArticleServices: TargetType {
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2")!
    }
    
    var path: String {
        switch self {
        case .fetchArticle:
            return "/top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchArticle:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchArticle(let country):
            return .requestParameters(parameters: ["country" : country, "apiKey" : "e9b514c39c5f456db8ed4ecb693b0040"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
