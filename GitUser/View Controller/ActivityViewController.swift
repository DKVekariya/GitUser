//
//  ActivityViewController.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 09/03/21.
//

import UIKit

class ActivityViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
    
    var isHidden:Bool {
        get {
            self.activityIndicator.isHidden
        }
        set {
            self.activityIndicator.isHidden = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activityIndicator.isHidden = false
        activityIndicator.color = .blue
        activityIndicator.startAnimating()

    }
    
    func onSuccess(_ users:[Users]) {
        self.activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func onError(_ error: Error) {
        print(error)
        self.activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
