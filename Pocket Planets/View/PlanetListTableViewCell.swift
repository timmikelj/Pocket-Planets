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
    
    func configureCell(with planet: Planet) {
        
        planetName.text = planet.name
        planetImageView.image = planet.image
        planetSize.text = "Diameter: \(planet.diameterInKm ?? 0) miles"
        planetDistanceFromSun.text = "Distance from Sun: \(planet.distanceFromSun ?? 0) million miles"
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
