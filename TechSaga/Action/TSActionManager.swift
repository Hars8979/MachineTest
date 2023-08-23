//
//  TSActionManager.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import UIKit

class TSActionManager {
    
    class func performAction(action: TSAction, sourceVC : UIViewController?) {
        if let redirectionType = action.redirectionType {
            performRedirection(redirectionType: redirectionType, action: action, sourceVC: sourceVC)
        }
    }
    
    class func performRedirection(redirectionType: TSRedirectionType, action: TSAction, sourceVC: UIViewController?) {
        switch redirectionType {
        case .auth: performAuthAction(action: action, sourceVC: sourceVC)
        case .home: performHomeAction(action: action, sourceVC: sourceVC)
        case .detail: performDetailAction(action: action, sourceVC: sourceVC)
        }
    }
    
    fileprivate class func performAuthAction(action: TSAction, sourceVC : UIViewController?) {
        if let authViewC = StoryBoardHelper.controller(.auth , type: TSAuthViewC.self) {
            let window =  APP_DELEGATE.window
            window?.rootViewController = nil
            let navigationController = UINavigationController(rootViewController: authViewC)
            navigationController.navigationBar.barStyle = .black
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    fileprivate class func performHomeAction(action: TSAction, sourceVC : UIViewController?) {
        if let homeViewC = StoryBoardHelper.controller(.home , type: TSHomeViewC.self) {
            let window =  APP_DELEGATE.window
            window?.rootViewController = nil
            let navigationController = UINavigationController(rootViewController: homeViewC)
            navigationController.navigationBar.barStyle = .black
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    fileprivate class func performDetailAction(action: TSAction, sourceVC : UIViewController?) {
        if let detailViewC = StoryBoardHelper.controller(.home , type: TSDetailViewC.self),
           let params = action.actionParams, let articleData = params.articleData{
            detailViewC.detailViewModel = TSDetailViewModel(newsArticleData: articleData)
            self.show(detailViewC, action: action, sourceVC: sourceVC, animation: true)
        }
    }
    
    fileprivate class func show(_ controller : UIViewController, action : TSAction?, sourceVC : UIViewController?, animation : Bool = true) {
        if sourceVC != nil {
            if let navigationController = (sourceVC as? UINavigationController) ?? sourceVC?.navigationController {
                navigationController.pushViewController(controller, animated:animation)
            }
        }
    }
}
