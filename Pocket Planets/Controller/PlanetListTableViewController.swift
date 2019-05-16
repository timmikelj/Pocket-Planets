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
    private let planetData = PlanetData()
    var globalSelectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register tableView custom cell
        planetTableView.register(UINib(nibName: "WelcomeTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlanetData.planetArray.count
    }

    // MARK: - Set up cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WelcomeTableViewCell
        
        cell.planetName.text = PlanetData.planetArray[indexPath.row]
        cell.planetImageView.image = planetData.planetImagesArray[indexPath.row]
        cell.planetSize.text = "Diameter: \(planetData.diameterInKm[indexPath.row]) miles"
        cell.planetDistanceFromSun.text = "Distance from Sun: \(planetData.distanceFromSun[indexPath.row]) million miles"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath) as! WelcomeTableViewCell
        
        let arVC = storyboard?.instantiateViewController(withIdentifier: ARViewController.identifier) as! ARViewController
        arVC.selectedPlanet = indexPath.row
        self.show(arVC, sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WelcomeTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WelcomeTableViewCell
        cell.planetImageView.frame = CGRect(x: 0, y: 0, width: 115, height: 115)
    }
    
    // TableViewCell animation
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
