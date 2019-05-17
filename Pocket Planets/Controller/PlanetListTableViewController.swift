//
//  WelcomeTableViewController.swift
//  Planets in AR
//
//  Created by Tim Mikelj on 20/02/2018.
//  Copyright © 2018 Tim Mikelj. All rights reserved.
//

import UIKit

class PlanetListTableViewController: UITableViewController {

    @IBOutlet var planetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        planetTableView.register(UINib(nibName: PlanetListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlanetListTableViewCell.identifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanetData.planets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanetListTableViewCell.identifier, for: indexPath) as! PlanetListTableViewCell
        let currentPlanet = PlanetData.planets[indexPath.row]
        
        cell.configureCell(with: currentPlanet)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedPlanet = PlanetData.planets[indexPath.row]
        let arVC = storyboard?.instantiateViewController(withIdentifier: ARViewController.identifier) as! ARViewController
        
        if selectedPlanet.type == .free {
            
            arVC.planet = selectedPlanet
            self.show(arVC, sender: nil)
            
        } else {
            
            if UserDef.isFullAccessPurchased() {
                
                arVC.planet = selectedPlanet
                show(arVC, sender: nil)
                
            } else {
                
                let iapVC = InAppPurchaseViewController()
                show(iapVC, sender: nil)
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }

}
