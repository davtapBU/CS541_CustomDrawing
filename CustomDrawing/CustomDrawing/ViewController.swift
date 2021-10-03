//
//  ViewController.swift
//  CustomDrawing
//
//  Created by David Tapia on 9/27/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    var myShape = ShapeBackground()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBSegueAction func addShapeView(_ coder: NSCoder) -> UIViewController? {
        let shape = UIHostingController(coder: coder, rootView: myShape)
        
        shape!.view.backgroundColor = UIColor.clear
        return shape
    }
}

