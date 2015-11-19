//
//  LoginViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/18/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var icon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icon.text = "\u{f080}"
    }

}