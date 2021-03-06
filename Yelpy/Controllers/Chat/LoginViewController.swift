//
//  LoginViewController.swift
//  Yelpy
//
//  Created by Memo on 7/1/20.
//  Copyright © 2020 memo. All rights reserved.
//


import UIKit
import Parse

class LoginViewController: UIViewController {

    
    /*------ Outlets ------*/
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    /*------ SIGN UP AND LOG IN FUNCTIONALITY  ------*/
    
    // ––––– LAB 5 TODO: SIGN UP FUNCTIONALITY
    @IBAction func onSignUp(_ sender: Any) {
        // Sign up user
        // Check text field inputs
        
        if !usernameAndPasswordNotEmpty()
        {
            // initialize a user object using the pf user
            let newUser = PFUser()
            
            // set user properties  using the text field from the UITextField
            
            newUser.username = usernameTextField.text
            newUser.password = passwordTextField.text
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error{
                    // error handling output
                    print(error.localizedDescription)
                    // print out the error in the console
                    self.displaySignupError(error: error)
                }
                // if there is no error in the sign up process
                // \ is a way to escape and add variables inside print statemenets !
                else {
                    print ("User \(newUser.username!) Registered Sucessfully!")
                    // call the notification to see the login to user
                    NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
                    
                }
                
            }
            
        }
        else{
            // this is mentioned as display empty error!
            displayError()
        }
        
        
        
        
    }
    
    
    // ––––– LAB 5 TODO: LOGIN FUNCTIONALITY
    @IBAction func onLogin(_ sender: Any) {
        // Login user
    
        
    }
    
    
    
    
    /*------ Handle text field inputs  ------*/
    func usernameAndPasswordNotEmpty() -> Bool {
        return usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
    }
    
    /*------ Alert Controllers ------*/
    // Text fields are empty alert controller
    func displayError() {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    // Login error alert controller
    func displayLoginError(error: Error) {
        let title = "Login Error"
        let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Sign up error alert controller
    func displaySignupError(error: Error) {
        let title = "Sign up error"
        let message = "Oops! Something went wrong while signing up: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
}



