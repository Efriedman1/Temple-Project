//
//  UserScreenVC.swift
//  ShowerTemp
//
//  Created by Nikhil on 3/8/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class UserScreenVC: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profilePicImage: UIImageView!
  
        override func viewDidLoad() {
        super.viewDidLoad()
            retrieveData()

    }
   
    var profileurl: String?
    //Gets the name for Welcome Screen
    func retrieveData(){
    let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                print(snapshot)
                self.nameLabel.text =  "Hi!, \((dictionary["name"])!)"
                 self.profileurl = (dictionary["profileImageUrl"] as! String?)!
                self.fetchUserProfileImage()
            }
        }, withCancel: nil)
    }
    
    func fetchUserProfileImage(){
        if let profileImageUrl = profileurl {
        profilePicImage.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
    
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        logOutPressed()
    }
    //LOGOUT
func logOutPressed() {
        let firebaseAuth = FIRAuth.auth()
        do{
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError{
            print("Sign Out error: %@", signOutError )
        }
       DataSerivce().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
       }
    //End Logout
    
    
    //ChatLog
    @IBAction func chatLogPressed(_ sender: Any) {
        let chatLogController = ChatLogVC()
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
  
    
   }
