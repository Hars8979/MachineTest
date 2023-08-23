//
//  NewsListTVC.swift
//  TechSaga
//
//  Created by Rishabh Jain on 23/08/23.
//

import UIKit
import SDWebImage

class NewsListTVC: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet weak var cornerView: UIView! {
        didSet {
            cornerView.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImageView: TSImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemBoderView: UIView!
    @IBOutlet weak var itemDateLabel: UILabel!
    
    
    //MARK: - Properties
    let gradientLayer = CAGradientLayer()
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = itemBoderView.bounds
                
                let colorSet = [UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 0.0),
                                UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]
                let location = [0.5, 1.0]
        
        itemBoderView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location, startEndPoints: (CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.5, y: 1.0)))
       
    }
    var newsArticleData: NewsArticleModel? {
        didSet {
            itemTitleLabel.text = newsArticleData?.title
            itemNameLabel.text = newsArticleData?.author
            if let publishedAt = newsArticleData?.publishedAt, !publishedAt.isEmpty {
                itemDateLabel.text = publishedAt.convertStringDate(formatFrom: StringConstants.DateFormat.yy_MM_dd_hh_ss, formatTo: StringConstants.DateFormat.yy_MM_dd)
            }
            if let imageURL = newsArticleData?.urlToImage, !imageURL.isEmpty, let imageView = self.itemImageView {
                self.itemImageView.contentMode = .scaleAspectFill
                self.itemImageView.imageURL = imageURL
                weak var weakSelf = self
                TSImageManager.downloadImage(imageView: imageView, imageURL: imageURL, placeholderImage: nil) { image in
                    if image != nil {
                        DispatchQueue.main.async {
                            weakSelf?.itemImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - View LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
}
extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero
        layer.cornerRadius = 12

        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }

        layer.colors = layerColorSet
        layer.locations = layerLocations
        

        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }

        self.layer.insertSublayer(layer, above: self.layer)
    }
}
