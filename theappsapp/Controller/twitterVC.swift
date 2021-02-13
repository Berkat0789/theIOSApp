//
//  twitterVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/10/21.
//

import UIKit
import SwifteriOS
import CoreML

class twitterVC: UIViewController {
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var emojiLabel: UILabel!
    
    var swifter = SwifterService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emojiLabel.text = "🤗"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        }

//        print(swifter.makePredicitonFOr(tweet: "@Twitter is a crazy stock")?.label)
        // Do any additional setup after loading the view.
   
    
    @IBAction func predictPressed(_ sender: Any) {
        guard let searchText = searchField.text else {fatalError("SearchField  cannot be empty")}
        swifter.searchFor(tweet: searchText) { (sentiment, score) in
            self.navigationItem.title = "Sentiment Score = \(score)"
            self.setEmojiFor(score: score)
            self.searchField.text = ""
        }
    }
    
    
    
    
    
}

extension twitterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = searchField.text else {fatalError("SearchField  cannot be empty")}
        swifter.searchFor(tweet: searchText) { (sentiment, score) in
            self.navigationItem.title = "Sentiment Score = \(score)"
            self.setEmojiFor(score: score)
            self.searchField.text = ""
        }
        return true
    }
    ///Setting a function that checks the score and sets image
    func setEmojiFor(score: Int) {
        if score > 8 {
            self.emojiLabel.text = "😋"
        } else if score < 0 {
            self.emojiLabel.text = "😢"
        } else {
            //Considering neutral
            self.emojiLabel.text = "😐"
        }
        
    }
}

