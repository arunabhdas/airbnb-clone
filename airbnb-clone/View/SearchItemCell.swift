//
//  SearchItemCell.swift
//  airbnb-clone
//
//  Created by Jun Tanaka on 2017/11/23.
//  Copyright © 2017年 Jun Tanaka. All rights reserved.
//


import UIKit

class SearchItemCell : UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var starRatingView: UIView!
    
    var travel: Travel? {
        didSet {
            thumbnail.image = UIImage(named: travel!.imageName)
            thumbnail.layer.cornerRadius = 6
            
            starRatingView.widthAnchor.constraint(equalToConstant: starRatingWidth(travel!.rating) ).isActive = true
            starRatingView.clipsToBounds = true
        }
    }
    
    func starRatingWidth(_ rating: Int) -> CGFloat {
        return CGFloat(rating * 20)
    }
}
