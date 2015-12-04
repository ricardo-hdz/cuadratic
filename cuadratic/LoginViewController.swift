//
//  LoginViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/18/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import FontAwesome_swift

class LoginViewController: UIViewController {

    @IBOutlet weak var icon: UILabel!
    @IBOutlet weak var connectToFoursquare: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signupLink: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var CODE: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icon.font = UIFont.fontAwesomeOfSize(100)
        icon.text = String.fontAwesomeIconWithCode("fa-cube")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        initializeApp()
    }
    
    func initializeApp() {
        let user = UserHelper.getInstance().getCurrentUser()
        if (user != nil) {
            indicator.startAnimating()
            NetworkRequestHelper.getInstance().token = user!.token
            indicator.stopAnimating()
            displayLandController()
        } else {
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.addObserver(self, selector: "codeReceived:", name: "foursquareCode", object: nil)
        }
    }
    
    func codeReceived(notification: NSNotification) {
        let object = notification.object!
        requestAccessTokenWithCode(object as! String)
    }
    
    func requestAccessTokenWithCode(code: String) {
        LoginHelper.getFoursquareAccessToken(code) { token, error in
            if let error = error {
                // display error in UI
                self.errorLabel.hidden = false
                self.errorLabel.text = error
            } else {
                // save token in session and segue
                self.setSessionToken(token!)
                self.indicator.stopAnimating()
                self.displayLandController()
            }
        }
    }
    
    func displayLandController() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("landingTabBarController") as! UITabBarController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func setSessionToken(token: String) {
        let _ = User(tokenValue: token, context: CoreDataHelper.getInstance().sharedContext)
        NetworkRequestHelper.getInstance().token = token
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    @IBAction func connectToFoursquare(sender: AnyObject) {
        indicator.startAnimating()
        let url = NetworkRequestHelper.Constants.LOGIN.AUTH_ENDPOINT
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    

}