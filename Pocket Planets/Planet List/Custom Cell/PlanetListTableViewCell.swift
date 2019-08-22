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
        
        setupUI()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        
        planetName.textColor = ppTextColor
        planetSize.textColor = ppTextColor
        planetDistanceFromSun.textColor = ppTextColor
        self.backgroundColor = ppBackgroundColor
    }
    
}
