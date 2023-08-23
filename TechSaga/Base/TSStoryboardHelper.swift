//
//  TSStoryboardHelper.swift
//  TechSaga
//
//  Created by Harshit Jain on 22/08/23.
//

import Foundation
import UIKit

enum StoryBoardType : String {
    case auth = "Auth"
    case home = "Home"
}

class StoryBoardHelper : NSObject {
    
    class func controller<T>(_ storyBoardType: StoryBoardType, type : T.Type ) -> T? {
        let storyboard = UIStoryboard(name: storyBoardType.rawValue , bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: type)) as? T
    }
    
    class func controller(_ storyBoardType : StoryBoardType, identifier : String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyBoardType.rawValue , bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
