//
//  CreateGroupViewController.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/20.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doneBtn.isHidden = true
    }

    @objc func textFieldDidChange() {
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnEamilArray) in
                self.emailArray = returnEamilArray
                self.tableView.reloadData()
            })
        }
        
    }

    @IBAction func doneBtnWasPressed(_ sender: Any) {
        
        if titleTextField.text != "" && descriptionTextField.text != "" {
            print("do btn press")
            DataService.instance.getIds(forUsername: chosenUserArray, handler: { (idsArray) in
                print("do btn press2")
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                        print("do btn press3")
                    } else {
                        print("Group could not create, please try again.")
                    }
                })
            })
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//
//extension CreateGroupViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return emailArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
//            return UITableViewCell()
//        }
//        let profileImage =  UIImage(named: "defaultProfileImage")
//        if chosenUserArray.contains(emailArray[indexPath.row]) {
//            print("emailArray \(emailArray) add \(emailArray[indexPath.row])")
//            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
//        } else {
//            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
//        }
//
//        return cell
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return }
//        print("emailArray~~~ \(emailArray)")
//        // if array don't contain this email, add it into array
//        if !chosenUserArray.contains(cell.emailLabel.text!) {
//            print("emailLabel Text: \(cell.emailLabel.text!)")
//            chosenUserArray.append(cell.emailLabel.text!)
//            //After add to array, show array on groupMemberLabel
//            groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
//            doneBtn.isHidden = false
//        } else {
//            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLabel.text!})
//            if chosenUserArray.count >= 1 {
//                groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
//                print("Now group member: \(groupMemberLabel.text!)")
//            } else {
//                groupMemberLabel.text = "add members to your group"
//                doneBtn.isHidden =  true
//            }
//        }
//    }
//
//
//
//}
//
//extension CreateGroupViewController: UITextFieldDelegate {
//
//}
//



extension CreateGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLabel.text!) {
            chosenUserArray.append(cell.emailLabel.text!)
            groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLabel.text! })
            if chosenUserArray.count >= 1 {
                groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLabel.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupViewController: UITextFieldDelegate {
    
}













