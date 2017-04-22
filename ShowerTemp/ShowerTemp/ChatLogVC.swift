//
//  ChatLogVC.swift
//  ShowerTemp
//
//  Created by Nikhil on 3/30/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit



class ChatLogVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //TextField
    
    @IBOutlet weak var messageEdit: UITextField!
    
    
    //Send Button

    @IBAction func sendPressed(_ sender: Any) {
        print(messageEdit.text!)
    }
    
    
    //Back Button
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    

}
