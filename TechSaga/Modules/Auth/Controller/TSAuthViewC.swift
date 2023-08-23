//
//  ViewController.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class TSAuthViewC: UIViewController {
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleLogin()
    }
    
    //MARK: - Fileprivate Methods
    
    fileprivate func setupGoogleLogin() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    fileprivate func redirectToHome() {
        let action = TSAction(redirectionType: .home, actionParams: nil)
        TSActionManager.performAction(action: action, sourceVC: self)
    }
    
    //MARK: - IBActions
    
    @IBAction func gmailLoggedInTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}

//MARK: - GIDSignInDelegate

extension TSAuthViewC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil, let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { [weak self] (authResult, error) in
            guard error == nil else { return }
            self?.redirectToHome()
        }
    }
}

