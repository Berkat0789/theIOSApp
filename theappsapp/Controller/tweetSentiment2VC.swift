//
//  tweetSentiment2VC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/13/21.
//

import UIKit

class tweetSentiment2VC: UIViewController {
    
    @IBOutlet weak var tweetTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    
    var tweets = [Tweet]()
    let service = TwitterSentiment2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registering Cell
        tweetTableView.register(UINib(nibName: K.cellIdentifiers.tweetCell, bundle: nil), forCellReuseIdentifier: K.cellIdentifiers.tweetCell)

    }

    @IBAction func searchPressed(_ sender: Any) {
        guard let tag = searchField.text else {return}
        service.searchForTweetsfor(value: tag, completed: { (tweetList, score)  in
            self.tweets = tweetList
            DispatchQueue.main.async {
                self.searchField.text = ""
                self.navigationItem.title = "The score for this sentiment is - \(score)"
                self.tweetTableView.reloadData()
            }
        })
    }
    
    
    
    
    
    
    
}



extension tweetSentiment2VC: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        guard let tweetCell = tweetTableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.tweetCell, for: indexPath) as? tweetCell else {return UITableViewCell()}
        tweetCell.updateCell(tweet: tweet)
        return tweetCell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let tag = searchField.text else {return false}
        service.searchForTweetsfor(value: tag, completed: { (tweetList, score) in
            self.tweets = tweetList
            DispatchQueue.main.async {
                self.searchField.text = ""
                self.navigationItem.title = "The score for this sentiment is \(score)"
                self.tweetTableView.reloadData()
            }
        })
     
        return true
    }
    
}
