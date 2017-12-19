//
//  CreatePostViewController.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/16.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit
import Firebase
class CreatePostViewController: UIViewController {

    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailLabel.text = Auth.auth().currentUser?.email
    }
    

    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
                if textView.text != nil && textView.text != "Say something here..." {
                    sendBtn.isEnabled = false
                    DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, WithGroupKey: nil, sendComplete: { (isComplete) in
                        if isComplete {
                            self.sendBtn.isEnabled = true
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            self.sendBtn.isEnabled = true
                            print("There's an error")
                        }
                    })
                }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}
