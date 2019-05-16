//
//  IAPTableViewCell.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

class IAPTableViewCell: UITableViewCell {
    
    static let identifier = "IAPTableViewCell"

    @IBOutlet var tickImageView: UIImageView!
    @IBOutlet var offerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
