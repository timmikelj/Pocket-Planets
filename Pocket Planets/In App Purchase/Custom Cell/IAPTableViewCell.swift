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
    
    func configureCell(with offer: Offer) {
        
        offerLabel.text = offer.offerText ?? ""
        
        loadUI()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func loadUI() {
        
        self.backgroundColor = ppBackgroundColor
        self.offerLabel.textColor = ppTextColor
        
        if UserDef.isDarkMode() {
            tickImageView.image = UIImage(named: tickDarkModeImageName)
        } else {
            tickImageView.image = UIImage(named: tickImageName)
        }
        
    }
    
}
