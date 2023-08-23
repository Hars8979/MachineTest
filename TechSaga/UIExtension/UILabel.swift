//
//  UILabel.swift
//  TechSaga
//
//  Created by Jain on 23/08/23.
//

import Foundation
import UIKit

class TSLabel: UILabel {

    override public func layoutSubviews() {
        super.addShadow()
    }
}

extension UILabel {
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
}
