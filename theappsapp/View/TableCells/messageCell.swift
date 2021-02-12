//
//  messageCell.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/9/21.
//

import UIKit

class messageCell: UITableViewCell {

    @IBOutlet weak var senderEmail: UILabel!
    @IBOutlet weak var messsageBody: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(message: Message) {
        self.senderEmail.text = message.sender
        self.messsageBody.text = message.body
    }
    
}
