//
//  MapViewController.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 3/16/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //my code :)
        menuButton.target = revealViewController()
        menuButton.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}
