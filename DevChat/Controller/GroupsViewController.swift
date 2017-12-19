//
//  GroupsViewController.swift
//  
//
//  Created by PeterChen on 2017/10/16.
//

import UIKit

class GroupsViewController: UIViewController {

    @IBOutlet weak var groupTableView: UITableView!
    
    var groupArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapShot) in
            DataService.instance.getAllGroups(handler: { (returnGroupsArray) in
                self.groupArray = returnGroupsArray.reversed()
                self.groupTableView.reloadData()
            })
        }
    }
    

}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupCell else { return UITableViewCell() }
        let group = groupArray[indexPath.row]
        cell.configureCell(title: group.groupTitle, description: group.groupDesc, memberCount: group.membersCount)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedViewController else {return }
        print("Go to GroupFeedVC")
        groupFeedVC.initData(forGroup: groupArray[indexPath.row])
        present(groupFeedVC, animated: true, completion: nil)
        
    }
    
    
}



















