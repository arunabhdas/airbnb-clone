//
//  ViewController.swift
//  airbnb-clone
//
//  Created by Jun Tanaka on 2017/10/30.
//  Copyright © 2017年 Jun Tanaka. All rights reserved.
//

import UIKit
import FontAwesomeKit

@IBDesignable
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITabBarControllerDelegate {
    
}
