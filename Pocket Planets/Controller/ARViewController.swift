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

class ARViewController: UIViewController, ARSCNViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    static let identifier = "ARViewController"
    
    let planetData = PlanetData()
    var selectedPlanet = Int()
    var selectedPlanetDiffuse = UIImage(named: "")
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var ARView: ARSCNView!
    
    @IBOutlet weak var imageInTheView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageInTheView.isHidden = true
        
        // Set the view's delegate
        ARView.delegate = self
        
        // Create GEOMETRY
        let marsSphere = SCNSphere(radius: 0.15)
        
        // Create Material & assign it to my object
        let material = SCNMaterial()
        let assetLink = "art.scnassets/\(PlanetData.planetPatternArray[selectedPlanet])"
        selectedPlanetDiffuse = UIImage(named: assetLink)
        material.diffuse.contents = selectedPlanetDiffuse
        marsSphere.materials = [material]
        
        // Create a NODE
        let node = SCNNode()
        node.position = SCNVector3(x : 0, y : 0.1, z : -0.5)
        node.geometry = marsSphere
        
        // Add node into my scene
        ARView.scene.rootNode.addChildNode(node)
        
        // Add realistic light
        ARView.autoenablesDefaultLighting = true
        
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func dimissButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Camera Button
    @IBAction func cameraButton(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "button pressed"), for: .selected)
        let image = ARView.snapshot()
        print("Image taken")
        imageInTheView.isHidden = false
        imageInTheView.image = image
        
        // dismiss Image in 5 seconds
        let imageDismiss = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: imageDismiss) {
            self.imageInTheView.isHidden = true
        }
        
        // Saving the image
        UIImageWriteToSavedPhotosAlbum(imageInTheView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "", message: "Image saved to photos.", preferredStyle: .alert)
            present(ac, animated: true)
            
            // dismiss in 1.5 seconds
            let alertDismiss = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: alertDismiss) {
                ac.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Done image capture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageInTheView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
        
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()

            // Run the view's session
            ARView.session.run(configuration)
            
        } else {
            
            print("Realistic AR experience is not available on this device.")
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        ARView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
