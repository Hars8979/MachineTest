//
//  TSHomeViewC.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import UIKit
import Firebase
import GoogleSignIn

class TSHomeViewC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    
    var homeViewModel: TSHomeViewModel = TSHomeViewModel()
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableViewSetup()
        fetchNewsHeadlines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func tableViewSetup() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(["TSNewsListTVC"])
    }
    
    fileprivate func fetchNewsHeadlines() {
        homeViewModel.getHeadlines() { [weak self] in
            DispatchQueue.main.async {
                self?.indicatorView.isHidden = true
                self?.tableView.reloadData()
            }
        }
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


