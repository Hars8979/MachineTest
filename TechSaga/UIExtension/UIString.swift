//
//  UIString.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import UIKit

extension String {
    
    //Convert string date to expected format
    func convertStringDate(formatFrom: String, formatTo: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = formatFrom
        if let dateFromString = formatter.date(from: self) {
            formatter.timeZone = .current
            formatter.dateFormat = formatTo
            let time: String = formatter.string(from: dateFromString)
            return time
        }
        return ""
    }
}
