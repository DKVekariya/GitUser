//
//  LoginViewController.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 05/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = UserDefaults.standard.value(forKey: "key-access-token") as? String {
           
            func showMainViewController() {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController: UINavigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let delegate = windowScene?.delegate as? SceneDelegate
                
                if let window = delegate?.window {
                    window.rootViewController = mainViewController
                }
            }
            showMainViewController()
        
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAuthSucess(_:)), name: NSNotification.Name("auth-success"), object: nil)
    }
    
    
    @objc func onAuthSucess(_ sender: Notification) {
        if let code = sender.object as? String {
            print("Code is: \(code)")
            
            
            let url = URL (string: String(format: "https://github.com/login/oauth/access_token", code))!
            var request = URLRequest(url: url)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            let parameters: [String: String] = ["client_id": "712fb85a261c094ae08c",
                                                "client_secret": "c5f2333407d4ee6abf5d3e16f8e9603217c3c9d9",
                                                "code": "\(code)",
                                                "redirect_uri": "DemoGithub://oauth"]
            request.httpBody = try? JSONEncoder().encode(parameters)
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                    print(response)
                    UserDefaults.standard.setValue(response.access_token, forKey: "key-access-token")
                } catch {
                    print(error)
                }
  
            }.resume()
        }
    }
    
    struct AccessTokenResponse: Codable {
        let access_token:String
        let token_type: String
    }


    @IBAction func logInButtonTapped(_ sender: Any) {
        
        let url = URL(string: String(format: "https://github.com/login/oauth/authorize?scope=nil&client_id=%@", "712fb85a261c094ae08c"))!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { (status) in
                print("Opne url status: ",status)
            }
        }

    }
}


