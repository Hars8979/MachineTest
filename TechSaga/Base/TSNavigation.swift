//
//  TSNavigation.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import UIKit

enum NavigationBarText: String {
    case empty = ""
    case headLines = "HEADLINES"
}

protocol CommonNavigationBar {
    func addLabel(title: NavigationBarText, textColor: UIColor, font: UIFont)
    func addLeftButton()
    func addRightButton(action: Selector?)
}

extension UIViewController {
    
    @objc func leftButtonDidPress() {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
            } else {
                navigationController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension CommonNavigationBar where Self: UIViewController {
    
    func addLabel(title: NavigationBarText, textColor: UIColor, font: UIFont) {
        if self.navigationController != nil {
            let leftTitleLabel = UILabel()
            leftTitleLabel.backgroundColor = .clear
            leftTitleLabel.text = title.rawValue
            leftTitleLabel.textColor = textColor
            leftTitleLabel.font = font
            leftTitleLabel.textAlignment = .center
            self.navigationItem.titleView = leftTitleLabel
            leftTitleLabel.frame = self.navigationController!.navigationBar.bounds
        }
    }
    
    func addLeftButton() {
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
            if navigationController.viewControllers.count > 1 {
                let barButton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) , style: .plain, target: self, action: #selector(leftButtonDidPress))
                self.navigationItem.leftBarButtonItems = [barButton]
                self.navigationItem.backBarButtonItem = nil
            }
        }
    }
    
    func addRightButton(action: Selector?) {
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
            let barButton = UIBarButtonItem(image: UIImage(named: "logout")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) , style: .plain, target: self, action: action)
            self.navigationItem.rightBarButtonItems = [barButton]
            self.navigationItem.backBarButtonItem = nil
        }
    }
}
