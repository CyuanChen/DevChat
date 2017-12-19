//
//  LoginViewController.swift
//  
//
//  Created by PeterChen on 2017/10/16.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: InsetTextField!
    
    @IBOutlet weak var passwordTextField: InsetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {

        
        if emailTextField.text != nil && passwordTextField.text != nil {
            AuthService.instance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    if (self.passwordTextField.text?.count)! < 6 {
                        let pwdWarning = UIAlertController(title: "Error", message: String(describing:(loginError?.localizedDescription)!), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        pwdWarning.addAction(okAction)
                        self.present(pwdWarning, animated: true, completion: nil)
                        self.passwordTextField.text?.removeAll()
                    }
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, loginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successfully registered user")
                        })
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
            })
        }
    }
    
    @IBAction func CloseBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension LoginViewController: UITextFieldDelegate {}








