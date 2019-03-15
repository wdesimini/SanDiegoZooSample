//
//  HomeViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "San Diego Zoo"
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        openApp("facebook://profile/28896772146", "https://www.facebook.com/SanDiegoZoo")
    }
    
    @IBAction func instagramTapped(_ sender: Any) {
        openApp("instagram://profile/1259368", "https://www.instagram.com/sandiegozoo/")
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        openApp("twitter://profile/15526913", "https://twitter.com/sandiegozoo/")
    }
    
    @IBAction func youtubeTapped(_ sender: Any) {
        openApp("youtube://www.youtube.com/user/SDZoo", "https://www.youtube.com/user/SDZoo")
    }
    
    func openApp(_ AppUrl: String,_ WebUrl: String) {
        UIApplication.tryURL([AppUrl, WebUrl])
    }
}

// Open applications/safari for social media links

extension UIApplication {
    class func tryURL(_ urlStrings: [String]) {
        let application = UIApplication.shared
        
        let urls = urlStrings.map { URL(string: $0) }
        
        urls.forEach {
            if application.canOpenURL($0!) {
                application.open($0!, options: [:], completionHandler: nil)
                
                return
            }
        }
    }
}
