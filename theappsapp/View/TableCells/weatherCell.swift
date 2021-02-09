//
//  weatherCell.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import UIKit

class weatherCell: UITableViewCell {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(weather: Weather) {
       self.cityName.text = weather.cityName
       self.descriptionLabel.text = weather.condition
        self.tempLabel.text = weather.tempString
    }
}
