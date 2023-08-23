//
//  TSActions.swift
//  TechSaga
//
//  Created by Harshit Jain on 22/08/23.
//

import Foundation

enum TSRedirectionType : String , CaseIterable {
    case auth = "TSAuthViewC"
    case home = "TSHomeViewC"
    case detail = "TSDetailViewC"
}

class TSAction {
    
    var redirectionType : TSRedirectionType?
    var actionParams : TSActionParams?
    
    init(redirectionType: TSRedirectionType, actionParams: TSActionParams?) {
        self.redirectionType = redirectionType
        self.actionParams = actionParams
    }
}

class TSActionParams {
    var link : String?
    var infoObject : Any?
}
