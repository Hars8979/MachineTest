//
//  UIFonts.swift
//  TechSaga
//
//  Created by Harshit Jain on 22/08/23.
//

import Foundation
import UIKit

enum FontStyle: String {
    case regular = "Regular",
         bold = "Bold"
}

extension UIFont {
    
    convenience init(_ size: CGFloat, _ style: FontStyle) {
        let fontName = "RobotoSlab-" + style.rawValue
        self.init(name: fontName, size: size)!
    }
}
