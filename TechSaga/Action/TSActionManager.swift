//
//  TSActionManager.swift
//  TechSaga
//
//  Created by Harshit Jain on 22/08/23.
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
        case .home: break
        case .detail: break
        }
    }
    
    fileprivate class func show(_ controller : UIViewController, action : TSAction?, sourceVC : UIViewController?, animation : Bool = true) {
        if sourceVC != nil {
            if let navigationController = (sourceVC as? UINavigationController) ?? sourceVC?.navigationController {
                navigationController.pushViewController(controller, animated:animation)
            }
        }
    }
    
    fileprivate class func navigationController(_ sourceVC : UIViewController?) -> UINavigationController? {
        return (sourceVC as? UINavigationController) ?? sourceVC?.navigationController
    }
}
