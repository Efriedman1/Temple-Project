//
//  UserListTableVC.swift
//  ShowerTemp
//
//  Created by Nikhil on 3/25/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
class UserListTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewBoard: UITableView!
    


    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //An Array to store all users
    var usersArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
            }
    
    //Fetching all Users
    func fetchUsers(){
        FIRDatabase.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
                if let dicionary = snapshot.value as? [String: AnyObject]{
                    let user = User()
                    //Setting the users email to the local variable email in User() class
                        user.name = dicionary["name"] as! String?
                        user.email = dicionary["email"] as! String?
                        user.profileImageUrl = dicionary["profileImageUrl"] as! String?
                    print(user.name!, user.email!)
                    
                    //Adding Users to the Array
                    self.usersArray.append(user)
                   self.tableViewBoard.reloadData()
                }
            
        }, withCancel: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }


    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return usersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usercell", for:  indexPath)  as! UserCell
        let user = usersArray[indexPath.row]
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.email
        //
        
        //Getting user's images
        if let profileImageUrl = user.profileImageUrl {
            
            cell.profileImage.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
//            let url = URL(string: profileImageUrl)
//         URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//            if(error != nil){
//            print(error!)
//                return
//            }
//            DispatchQueue.main.async {
//                 cell.profileImage.image = UIImage(data: data!)
//            }
//           
//         }).resume()
        }
        
        return cell
    }
//    let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
//        if error != nil{
//            print(error as Any)
//            return
//        }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
