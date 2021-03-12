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
            newValue ? stop() : start()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func onSuccess(_ users:[Users]) {
        stop()
    }
    
    func onError(_ error: Error) {
        stop()
    }
    
    func start() {
        activityIndicator.isHidden = false
        activityIndicator.color = .blue
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
