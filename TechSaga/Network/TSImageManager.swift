//
//  TSImageManager.swift
//  TechSaga
//
//  Created by Harshit Jain on 23/08/23.
//

import Foundation
import SDWebImage
import UIKit

class TSImageView: UIImageView {
    
    var imageURL : String?

    override public func layoutSubviews() {
        super.layoutSubviews()
    }
}

let imageCache = NSCache<AnyObject, UIImage>()

class TSImageManager {
    
    class func downloadImage(imageView: UIImageView, imageURL: String?, placeholderImage : UIImage? = nil, completionHandler: ((UIImage?) -> Void)? = nil) {
        
        if let _imageURL = imageURL {
            if let cachedImage = imageCache.object(forKey: _imageURL as AnyObject) {
                completionHandler?(cachedImage)
                return
            }
            DispatchQueue.global().async {
                if let url = URL(string: _imageURL) {
                    imageView.sd_setImage(with: url, completed: { (image, _, _, _) in
                        if image == nil {
                            completionHandler?(nil)
                        } else {
                            imageCache.setObject(image!, forKey: _imageURL as AnyObject)
                            completionHandler?(image)
                        }
                    })
                }
            }
        }
    }
}
