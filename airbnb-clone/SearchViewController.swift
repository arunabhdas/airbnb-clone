//
//  SearchViewController.swift
//  airbnb-clone
//
//  Created by Jun Tanaka on 2017/10/30.
//  Copyright © 2017年 Jun Tanaka. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchByDateButton: UIButton!
    @IBOutlet weak var searchByNumberOfPeopleButton: UIButton!
    @IBOutlet weak var expandableHeader: SearchExpandableHeader!

    var previousContentOffset: CGFloat = 0
    var categories = ["Food & Drink", "Art & Design", "Life Style", "Nature"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        expandableHeader.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func generateTravels(indexPath: IndexPath) -> [Travel] {
        var travels: [Travel] = []
        for i in 0..<5 {
            let travel = Travel(imageName: "travel_\(indexPath.section)_\(i)", rating: Int(arc4random_uniform(10)+1))
            travels.append(travel)
        }
        return travels
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        previousContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let deltaYOffset = scrollView.contentOffset.y - previousContentOffset
        let isScrollingDown = deltaYOffset > 0 && !isTopReached(scrollView)
        let isScrollingUp = deltaYOffset < 0 && !isBottomReached(scrollView)
        
        if expandableHeader.canAnimate(scrollView) {
            let newHeight = nextHeight(isScrollingDown: isScrollingDown, isScrollingUp: isScrollingUp, deltaYOffset: deltaYOffset, currentHeight: expandableHeader.heightConstraintConstant)
            
            if newHeight != expandableHeader.heightConstraintConstant {
                expandableHeader.heightConstraintConstant = newHeight
                setScrollPosition(position: previousContentOffset)
            }
        }
    }
    
    private func nextHeight(isScrollingDown: Bool, isScrollingUp: Bool, deltaYOffset: CGFloat, currentHeight: CGFloat)  -> CGFloat {
        
        if isScrollingDown {
            return max(expandableHeader.minimumHeight, expandableHeader.heightConstraintConstant - abs(deltaYOffset))
        } else if isScrollingUp {
             return min(expandableHeader.maximumHeight, expandableHeader.heightConstraintConstant + abs(deltaYOffset))
        }
        return currentHeight
    }
    
    private func isTopReached(_ scrollView: UIScrollView) -> Bool {
        let absoluteTop: CGFloat = 0
        return scrollView.contentOffset.y <= absoluteTop
    }
    
    private func isBottomReached(_ scrollView: UIScrollView) -> Bool {
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        return scrollView.contentOffset.y >= absoluteBottom
    }
    
    // NOTE: see https://stackoverflow.com/questions/39875153/table-view-numberofsections-method-is-not-getting-called-in-swift3
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCollectionCell") as! SearchCollectionCell
        cell.title = categories[indexPath.section]
        cell.travels = generateTravels(indexPath: indexPath)
        
        return cell
    }
    
    func setScrollPosition(position: CGFloat) {
        tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: position)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // scrolling has stopped
        expandableHeader.snap()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            // scrolling has stopped
            expandableHeader.snap()
        }
    }
}

extension SearchViewController: SearchExpandableHeaderDelegate {
    func updateLayout() {
        self.view.layoutIfNeeded()
    }
}
