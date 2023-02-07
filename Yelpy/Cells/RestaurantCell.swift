//
//  RestaurantCell.swift
//  Yelpy
//
//  Created by Kabir Dhillon on 2/7/23.
//  Copyright © 2023 memo. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var restaurantView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
