//
//  WelcomeTableViewCell.swift
//  Planets in AR
//
//  Created by Tim Mikelj on 20/02/2018.
//  Copyright © 2018 Tim Mikelj. All rights reserved.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetSize: UILabel!
    @IBOutlet weak var planetDistanceFromSun: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
