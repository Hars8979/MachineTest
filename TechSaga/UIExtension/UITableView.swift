//
//  UITableView.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(_ nibs: [String]?, inBundle bundle: Bundle? = nil) {
        if let nibArray = nibs {
            for nibName in nibArray {
                self.register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: nibName)
            }
        }
    }
}
