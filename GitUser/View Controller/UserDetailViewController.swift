//
//  UserDetailViewController.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 09/03/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var userleNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    var profile:Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = profile else { return }
        
        
        userleNameLabel.text = user.login
        avtarImageView.downloaded(from: user.avatar_url)
        
        getUserDetails(completed: onSuccess(_:), errorblock: onError(_:))
    }
    
    func onSuccess(_ user:Users) {
        if let followersCount = user.followers {
            followersLabel.text = String(followersCount)
        } else {
            followersLabel.text = "--"
        }
        
        if let followingCount = user.following {
            followingLabel.text = String(followingCount)
        } else {
            followingLabel.text = "--"
        }
    }

    func onError(_ error: Error) {

    }
    
    func getUserDetails(completed:@escaping (Users) -> (), errorblock: @escaping ((Error) -> ())  ){
        guard let user = profile, let url =  URL(string: user.url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async{
                    errorblock(error)
                }
            } else {
                do {
                    let _users = try JSONDecoder().decode(Users.self, from: data!)
                    DispatchQueue.main.async{
                        completed(_users)
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

    extension UIImageView {
        func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
        func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }
