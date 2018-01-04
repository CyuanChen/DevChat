//
//  AuthViewController.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/16.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
//import FBSDKLoginKit

class AuthViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(loginVC!, animated: true, completion: nil)
    }
    @IBAction func facebookSignInBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //使用者與app斷線時調用
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect error: \(error)")
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("GOOGLE SIGN IN")
        if error != nil {
            print("Sign in error: \(error)")
            return
        }
        
        guard let authentication = user.authentication else {
            return
        }
        
        // 憑證
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            print("Auth SIGN IN")
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            self.dismiss(animated: true, completion: nil)
            
            // Present the main view
//            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
//                UIApplication.shared.keyWindow?.rootViewController = viewController
//                self.dismiss(animated: true, completion: nil)
//            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
