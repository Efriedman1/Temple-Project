//
//  SignUpVC.swift
//  ShowerTemp
//
//  Created by Nikhil on 3/7/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataSerivce().keyChain
        if keyChain.get("uid") != nil{
            performSegue(withIdentifier: "SignUp", sender: nil)
        }
    }
    
    func completeSignIn(id: String){
        let key = DataSerivce().keyChain
        key.set(id, forKey: "uid")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        if (passwordField.text == confirmField.text){
            if let email = emailField.text, let password = passwordField.text, let name = nameField.text, picStatus {
               FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print("cant sign in user")
                } else {
                   guard let uid = user?.uid else{
                    return
                    }
                    //Saving Image to the Storage
                    let storageRef = FIRStorage.storage().reference().child("Profile Images").child("\(uid)profilePic.jpg")
                    
                    //Lower Resolution
                    if let uploadData = UIImageJPEGRepresentation(self.profileImage.image!, 0.4){
                    //Higher resolution
//                    if let uploadData = UIImagePNGRepresentation(self.profileImage.image!) {
                    storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                            print(error!)
                        }
                            if let profileImageUrl  = metadata?.downloadURL()?.absoluteString {
                            let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                            self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        }
                    })
                    }
                    //Done Saving Image
                }
               })
            }
        }
        }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]){
        //Saving user in DataBase Name and Email
        let ref = FIRDatabase.database().reference(fromURL: "https://showertemp.firebaseio.com/")
        let usersFolder = ref.child("Users").child((uid)) //creates users folder and inside of that creates another folder of users UID
//        let values = ["name": name, "email": email, "profileImageUrl": metadata.downloadUrl]
        usersFolder.updateChildValues(values, withCompletionBlock: { (err, ref) in //means that update name and email inside the users/UID folder
            if err != nil {
                print(err!)  ///If there is an error
                return
            }
            //User Saved in DB
            print("User Saved in Database")
        })
        //Ends here for that
        self.completeSignIn(id: uid)
        self.dismiss(animated: true, completion: nil)
    }
//    func tranferringToUserScreen(){
//    performSegue(withIdentifier: "signIn", sender: nil)
//    }
    
  
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    
    //ImagePicker
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func profilePicPressed(_ sender: Any) {
        handleSelectProfileImageView()
    }

    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        //Selected Image
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            profileImage.image = selectedImage
            self.bool()
        }
        //End-Selected Image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    var picStatus = false
    func bool(){
        picStatus = true
    }
   

}
