//
//  RecentSearchTableViewCell.swift
//  WeatherApp
//
//  Created by Vishnu V on 23/11/22.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var favIcon: UIImageView!
    
    @IBOutlet weak var lableCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
