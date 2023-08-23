//
//  GradientVw.swift
//  TechSaga
//
//  Created by call soft on 23/08/23.
//

import Foundation
import UIKit

class GradientVw: UIView{
    let gradient: CAGradientLayer = CAGradientLayer()
            required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            //self.titleLabel?.font = UIFont(name: "Myfont", size: 14)
            self.clipsToBounds = true
            self.layer.cornerRadius = 25
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    
    //MARK: func for gradient
        func applyGradient() -> Void {
               
                gradient.frame = self.bounds
          
                let color0 = UIColor(red:166/255, green:124/255, blue:226/255, alpha:1).cgColor
                let color1 = UIColor(red:211/255, green:186/255, blue: 252/255, alpha:1).cgColor
               
                gradient.colors = [color0,color1]
                gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                self.layer.insertSublayer(gradient, at: 0)
            }
}
