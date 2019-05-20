//
//  PlanetListTableViewCell.swift
//  Planets in AR
//
//  Created by Tim Mikelj on 20/02/2018.
//  Copyright © 2018 Tim Mikelj. All rights reserved.
//

import UIKit

class PlanetListTableViewCell: UITableViewCell {
    
    static let identifier = "PlanetListTableViewCell"
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetSize: UILabel!
    @IBOutlet weak var planetDistanceFromSun: UILabel!
    
    private var restrictionView = UIView()
    private var restrictionLabel = UILabel()
    
    func configureCell(with planet: Planet) {
        
        planetName.text = planet.name
        planetImageView.image = planet.image
        planetSize.text = "Diameter: \(planet.diameterInKm.convertToUserFriendlyDistance()) \(systemDistanceUnit())"
        planetDistanceFromSun.text = "Distance from Sun: \(planet.distanceFromSun.convertToUserFriendlyDistance()) million \(systemDistanceUnit())"
        
        if !UserDef.isFullAccessPurchased() && planet.type == IAPOfferType.fullAccess {
            loadRestrictionView()
        } else {
            removeRestrictionView()
        }
        
        setupUI()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadRestrictionView()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func loadRestrictionView() {
        
        /// Restriction view config
        restrictionView.backgroundColor = ppBackgroundColor
        
        if !self.contentView.subviews.contains(restrictionView) {
        
            restrictionView.frame = self.contentView.bounds
            restrictionView.alpha = 0.9
            
            self.contentView.addSubview(restrictionView)
            
        } else {
            restrictionView.isHidden = false
        }
        
        /// Restriction label config
        restrictionLabel.textColor = ppTextColor
        
        if !self.contentView.subviews.contains(restrictionLabel) {
            
            restrictionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: restrictionView.layer.frame.width, height: 34))
            restrictionLabel.text = "See With Full Access"
            restrictionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            restrictionLabel.textAlignment = .center
            restrictionLabel.center = restrictionView.center
            
            self.contentView.addSubview(restrictionLabel)
            
        } else {
            restrictionLabel.isHidden = false
        }
        
    }
    
    func removeRestrictionView() {
        self.restrictionView.isHidden = true
        self.restrictionLabel.isHidden = true
    }
    
    private func setupUI() {
        
        planetName.textColor = ppTextColor
        planetSize.textColor = ppTextColor
        planetDistanceFromSun.textColor = ppTextColor
        self.backgroundColor = ppBackgroundColor
    }
    
}
