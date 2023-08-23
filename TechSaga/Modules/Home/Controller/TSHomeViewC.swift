//
//  TSHomeViewC.swift
//  TechSaga
//
//  Created by Rishabh Jain on 22/08/23.
//

import UIKit
import Firebase
import GoogleSignIn

class TSHomeViewC: UIViewController {
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    fileprivate func redirectToAuth() {
        let action = TSAction(redirectionType: .auth, actionParams: nil)
        TSActionManager.performAction(action: action, sourceVC: self)
    }
    
   
    }


//MARK: - CommonNavigationBar

extension TSHomeViewC: CommonNavigationBar {
    
    fileprivate func setupNavBar() {
        addLabel(title: .headLines, textColor: .white, font: UIFont(29, .bold))
    }
}


