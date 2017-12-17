//
//  SearchExpandableHeader.swift
//  airbnb-clone
//
//  Created by Jun Tanaka on 2017/12/10.
//  Copyright © 2017年 Jun Tanaka. All rights reserved.
//

import Foundation

protocol SearchExpandableHeaderDelegate {
    func updateLayout()
}

class SearchExpandableHeader: UIView {
    
    @IBOutlet weak var searchConditionsView: UIStackView!
    @IBOutlet fileprivate weak var _heightConstraint: NSLayoutConstraint!
    var delegate: SearchExpandableHeaderDelegate?
    
    public var heightConstraintConstant: CGFloat {
        get {
            return _heightConstraint.constant
        }
        
        set (newHeightConstraintConstant) {
            _heightConstraint.constant = newHeightConstraintConstant
            updateProgress()
        }
    }
    
    private var range : CGFloat {
        get {
            return (maximumHeight - minimumHeight)
        }
    }
    
    public var progress: CGFloat {
        get {
            return _progress
        }
    }
    
    private var _progress: CGFloat = 0.0
    
    public var maximumHeight: CGFloat {
        get {
            return _maximumHeight
        }
        
        set (newMaximumHeight) {
            _maximumHeight = fmax(newMaximumHeight, 0.0)
        }
    }

    private var _maximumHeight: CGFloat = 140
    
    public var minimumHeight: CGFloat {
        get {
            return _minimumHeight
        }
        
        set (newMinimumHeight) {
            _minimumHeight = fmax(newMinimumHeight, 0.0)
        }
    }
    
    private var _minimumHeight: CGFloat = 90
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _maximumHeight = bounds.maxY
        _progress = 1.0
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.searchConditionsView.alpha = self._progress
        })
    }
    
    private func updateProgress() {
        let openAmount = _heightConstraint.constant - minimumHeight
        let newProgress = openAmount / range
        
        _progress = fmin(fmax(newProgress, 0.0), 1.0)
    }
    
    func snap() {
        let midPoint = minimumHeight + (range / 2)
        
        if heightConstraintConstant > midPoint {
            expand()
        } else {
            collapse()
        }
    }
    
    func canAnimate(_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + range
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    private func expand() {
        self.delegate?.updateLayout()
        self.heightConstraintConstant = self.maximumHeight
        UIView.animate(withDuration: 0.6, animations: {
            self.delegate?.updateLayout()
        })
    }
    
    private func collapse() {
        self.delegate?.updateLayout()
        self.heightConstraintConstant = self.minimumHeight
        UIView.animate(withDuration: 0.6, animations: {
            self.delegate?.updateLayout()
        })
    }

}


