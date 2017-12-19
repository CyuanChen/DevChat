//
//  MeViewController.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/16.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit
import Firebase

class MeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutBtnWasPress(_ sender: Any) {
        let logoutPop = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthViewController
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        
        logoutPop.addAction(logoutAction)
        present(logoutPop, animated: true, completion: nil)
        
        
        
    }
    

}


















