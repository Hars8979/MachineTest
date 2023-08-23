//
//  TSDetailViewC.swift
//  TechSaga
//
//  Created by  Jain on 23/08/23.
//

import UIKit

class TSDetailViewC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: TSLabel! {
        didSet {
            titleLabel.text = detailViewModel.getArticleData().title
        }
    }
    @IBOutlet weak var shadowViews: UIView!{
        didSet {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0.0, 1.0]

            // Set the start and end points for the gradient layer
    //            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

            // Set the frame to the layer
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.shadowViews.frame.size.width, height: self.shadowViews.frame.size.height)

            // Add the gradient layer as a sublayer to the background view
            shadowViews.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    
    @IBOutlet weak var imageView: TSImageView! {
        didSet {
            if let imageURL = detailViewModel.getArticleData().urlToImage, !imageURL.isEmpty, let imageView = self.imageView {
                self.imageView.contentMode = .scaleAspectFill
                self.imageView.imageURL = imageURL
                weak var weakSelf = self
                TSImageManager.downloadImage(imageView: imageView, imageURL: imageURL, placeholderImage: nil) { image in
                    if image != nil {
                        DispatchQueue.main.async {
                            weakSelf?.imageView.image = image
                        }
                    }
                }
            }
        }
    }
    @IBOutlet weak var authorLabel: TSLabel! {
        didSet {
            authorLabel.text = detailViewModel.getArticleData().author
        }
    }
    @IBOutlet weak var dateLabel: TSLabel! {
        didSet {
            if let publishedAt = detailViewModel.getArticleData().publishedAt, !publishedAt.isEmpty {
                dateLabel.text = publishedAt.convertStringDate(formatFrom: StringConstants.DateFormat.yy_MM_dd_hh_ss, formatTo: StringConstants.DateFormat.yy_MM_dd)
            }
        }
    }
    @IBOutlet weak var decsriptionLabel: UILabel! {
        didSet {
            decsriptionLabel.text = detailViewModel.getArticleData().description
        }
    }
    
    //MARK: - Properties
    
    var detailViewModel: TSDetailViewModel!
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .clear
    }
}

//MARK: - CommonNavigationBar

extension TSDetailViewC: CommonNavigationBar {
    
    fileprivate func setupNavBar() {
        addLabel(title: .empty, textColor: .white, font: UIFont(29, .bold))
        addLeftButton()
    }
}
