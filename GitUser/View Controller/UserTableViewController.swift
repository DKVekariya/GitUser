//
//  UserTableViewController.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 09/03/21.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var profiles = [Users]()
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        tableView.delegate = self
        tableView.dataSource = self

        downloadJson(completed: onSuccess(_:), errorblock: onError(_:))
        

    }
    
    func onSuccess(_ users:[Users]) {
        self.profiles = users
        self.tableView.reloadData()
    }
    
    func onError(_ error: Error) {
        print(error)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! UserTableViewCell
        cell.profileNameLabel?.text = profiles[indexPath.row].login
        cell.profileImageView.downloaded(from: profiles[indexPath.row].avatar_url)


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailViewController {
            destination.profile = profiles[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJson(completed: @escaping ([Users]) -> (), errorblock: @escaping ( (Error) -> () )) {
            let url = URL(string:"https://api.github.com/users")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async{
                        errorblock(error)
                    }
                } else {
                    do {
                        let users = try JSONDecoder().decode([Users].self, from: data!)
                        DispatchQueue.main.async{
                            completed(users)
                        }
                    } catch let error {
                        print("JSON Error")
                        DispatchQueue.main.async{
                            errorblock(error)
                        }
                    }

                }
                
            }.resume()
        }


}
