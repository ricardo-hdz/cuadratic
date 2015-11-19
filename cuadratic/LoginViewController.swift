//
//  LoginViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/18/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class LoginViewController: UIViewController {

    @IBOutlet weak var icon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icon.font = UIFont.fontAwesomeOfSize(100)
        icon.text = String.fontAwesomeIconWithCode("fa-cube")
    }

}