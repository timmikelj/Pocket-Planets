//
//  ViewController.swift
//  AR Shenanigans
//
//  Created by Tim Mikelj on 10/02/2018.
//  Copyright © 2018 Tim Mikelj. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    let planetData = PlanetData()
    var selectedPlanet = Int()
    var selectedPlanetDiffuse = UIImage(named: "")
    
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create GEOMETRY
        let marsSphere = SCNSphere(radius: 0.15)
        
        // Create Material & assign it to my object
        let material = SCNMaterial()
        let assetLink = "art.scnassets/\(planetData.planetPatternArray[selectedPlanet])"
        selectedPlanetDiffuse = UIImage(named: assetLink)
        material.diffuse.contents = selectedPlanetDiffuse
        marsSphere.materials = [material]
        
        // Create a NODE
        let node = SCNNode()
        node.position = SCNVector3(x : 0, y : 0.1, z : -0.5)
        node.geometry = marsSphere
        
        // Add node into my scene
        sceneView.scene.rootNode.addChildNode(node)
        
        // Add realistic light
        sceneView.autoenablesDefaultLighting = true
        
        // Add back button
        let button = UIButton(frame: CGRect(x: 20, y: 10, width: 50, height: 50))
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
            
        } else {
            print("Realistic AR experience is not available on this device.")
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
