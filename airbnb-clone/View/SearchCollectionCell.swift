//
//  SearchCollectionCell.swift
//  airbnb-clone
//
//  Created by Jun Tanaka on 2017/11/21.
//  Copyright © 2017年 Jun Tanaka. All rights reserved.
//

import UIKit

class SearchCollectionCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var travels: [Travel] = [Travel]() {
        didSet {
            collectionView.reloadData()
        }
    }
}

extension SearchCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchItemCell", for: indexPath) as! SearchItemCell
        cell.travel = travels[indexPath.item]
        return cell
    }
}
