//
//  tweetCell.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/13/21.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var sentimantLabel: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    @IBOutlet weak var tweetBubble: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetBubble.layer.cornerRadius = tweetBubble.frame.size.height / 5
        // Initialization code
    }
    
    func updateCell(tweet: Tweet) {
        self.senderLabel.text = tweet.sender
        self.sentimantLabel.text = tweet.sentimentValue
        self.tweetBody.text = tweet.text
    }
    
}
