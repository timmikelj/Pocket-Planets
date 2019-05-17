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
    
    func configureCell(with planet: Planet) {
        
        planetName.text = planet.name
        planetImageView.image = planet.image
        planetSize.text = "Diameter: \(planet.diameterInKm ?? 0) miles"
        planetDistanceFromSun.text = "Distance from Sun: \(planet.distanceFromSun ?? 0) million miles"
        
        if !UserDef.isFullAccessPurchased() && planet.type == IAPOfferType.fullAccess {
            restrictionView.isHidden = false
        } else {
            restrictionView.isHidden = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRestrictionView()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupRestrictionView() {
        
        if !self.contentView.subviews.contains(restrictionView) {
        
            restrictionView.frame = self.contentView.bounds
            restrictionView.backgroundColor = ppNavigationControllerBackgroundColor
            restrictionView.alpha = 0.7
            
            let restrictionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: restrictionView.layer.frame.width, height: 34))
            restrictionLabel.text = "See With Full Access"
            restrictionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            restrictionLabel.textAlignment = .center
            restrictionLabel.textColor = ppNavigationControllerTextColor
            restrictionLabel.center = restrictionView.center
            
            restrictionView.addSubview(restrictionLabel)
            self.contentView.addSubview(restrictionView)
            
        }
        
    }
    
    func removeRestrictionView() {
        self.restrictionView.removeFromSuperview()
    }
    
}
