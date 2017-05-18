//
//  WeeksWeatherTableViewCell.swift
//  MyweatherApp
//
//  Created by admin on 4/20/17.
//  Copyright © 2017 Anuja. All rights reserved.
//

import UIKit

class WeeksWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weekName: UILabel!
    @IBOutlet weak var minTemparature: UILabel!
    @IBOutlet weak var maxTemparature: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    func updateLabel(name:String, minTemp:String, maxTemp:String){
        
        weekName.text = name
        minTemparature.text = minTemp + "\u{00B0}" + "F"
        maxTemparature.text = maxTemp + "\u{00B0}" + "F"
        
    }
    
}
