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
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
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
        // verify of logged in, if not request
        let userData = fetchUserData()
        if (userData.count > 0) {
            indicator.startAnimating()
            let user = userData[0] as User
            NetworkRequestHelper.getInstance().token = user.token
            print("Token from session: \(user.token)")
            indicator.stopAnimating()
            displayLandController()
        } else {
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.addObserver(self, selector: "codeReceived:", name: "foursquareCode", object: nil)
        }
    }
    
    func fetchUserData() -> [User] {
        return CoreDataHelper.getInstance().fetchData("User") as! [User]
    }
    
    func codeReceived(notification: NSNotification) {
        let object = notification.object!
        print("Notfication received: \(object)")
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
                print("Token: \(token)")
                self.setSessionToken(token!)
                self.indicator.stopAnimating()
                self.displayLandController()
            }
        }
    }
    
    func displayLandController() {
        print("Displaying controller")
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("landingTabBarController") as! UITabBarController
        self.presentViewController(controller, animated: true, completion: nil)
        //self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setSessionToken(token: String) {
        let _ = User(tokenValue: token, context: sharedContext)
        NetworkRequestHelper.getInstance().token = token
        CoreDataStackManager.sharedInstance().saveContext()
        print("Token Saved")
    }
    
    @IBAction func connectToFoursquare(sender: AnyObject) {
        indicator.startAnimating()
        let url = NetworkRequestHelper.Constants.LOGIN.AUTH_ENDPOINT
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    

}