//
//  TSHomeViewC+UITableView.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource

extension TSHomeViewC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsListTVC = tableView.dequeueReusableCell(withIdentifier: "TSNewsListTVC", for: indexPath) as? TSNewsListTVC else { return UITableViewCell() }
        newsListTVC.newsArticleData = homeViewModel.getDataAt(indexPath)
        return newsListTVC
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let params = TSDetailActionParam()
        params.articleData = homeViewModel.getDataAt(indexPath)
        let action = TSAction(redirectionType: .detail, actionParams: params)
        TSActionManager.performAction(action: action, sourceVC: self)
    }
}

//MARK: - UITableViewDelegate

extension TSHomeViewC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
