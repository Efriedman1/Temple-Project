//
//  ViewController.swift
//  ShowerTemp
//
//  Created by Nikhil on 3/7/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KeychainSwift

class MainVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataSerivce().keyChain
        if keyChain.get("uid") != nil{
            performSegue(withIdentifier: "SignIn", sender: nil)
        }
    }
    
    //Other way
//    override func viewDidAppear(_ animated: Bool) {
//        let currentUser = FIRAuth.auth()?.currentUser?.uid
//        if currentUser != nil {
//            performSegue(withIdentifier: "SignIn", sender: nil)
//            print("TEST2")
//        }
//    }
    
    

func completeSignIn(id: String){
        let key = DataSerivce().keyChain
        key.set(id, forKey: "uid")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
        
    

    
    @IBAction func signUpPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "transfer", sender: nil)
    }
   

    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailField.text , let password = passwordField.text {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {               //if there is no error
                        self.completeSignIn(id: user!.uid)
                        print("Signed IN")
                        self.performSegue(withIdentifier: "SignIn", sender: nil)
                    }
                    })
                    }
        }
    }


