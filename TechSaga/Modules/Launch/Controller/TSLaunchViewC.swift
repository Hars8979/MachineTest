//
//  TSLaunchViewC.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import UIKit
import Firebase

class TSLaunchViewC: UIViewController {
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        manageRedirection()
    }
    
    //MARK: - Fileprivate Methods
    
    fileprivate func manageRedirection() {
        let redirectionType: TSRedirectionType = Auth.auth().currentUser == nil ? .auth : .home
        let action = TSAction(redirectionType: redirectionType, actionParams: nil)
        TSActionManager.performAction(action: action, sourceVC: self)
    }
}
