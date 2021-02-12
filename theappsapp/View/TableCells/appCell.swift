//
//  appCell.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import UIKit

class appCell: UITableViewCell {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet weak var cellBubble: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBubble.layer.cornerRadius = cellBubble.frame.size.height / 4
        // Initialization code
    }
    
    
    func updateCell(app: Apps) {
        self.appName.text = app.name
        self.appDescription.text = app.description
    }
    
    
}
