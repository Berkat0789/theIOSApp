//
//  twitterVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/10/21.
//

import UIKit
import SwifteriOS

class twitterVC: UIViewController {
    
    
    var swifter = SwifterService()

    override func viewDidLoad() {
        super.viewDidLoad()

        swifter.searchFor(tweet: "@apple")
        // Do any additional setup after loading the view.
    }
    
}
