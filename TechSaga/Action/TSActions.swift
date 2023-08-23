//
//  TSActions.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation

enum TSRedirectionType : String , CaseIterable {
    case auth = "TSAuthViewC"
    case home = "TSHomeViewC"
    case detail = "TSDetailViewC"
}

class TSAction {
    
    var redirectionType : TSRedirectionType?
    var actionParams : TSDetailActionParam?
    
    init(redirectionType: TSRedirectionType, actionParams: TSDetailActionParam?) {
        self.redirectionType = redirectionType
        self.actionParams = actionParams
    }
}

class TSDetailActionParam {
    var articleData: NewsArticleModel?
}
