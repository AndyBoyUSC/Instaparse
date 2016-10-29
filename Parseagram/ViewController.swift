//
//  ViewController.swift
//  Parseagram
//
//  Created by Andrew Szot on 10/29/16.
//  Copyright © 2016 AndrewSzot. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock {
            (success: Bool, error: NSError?) ->
            Void in
            if success {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else {
                
            }
        }
    }
}

