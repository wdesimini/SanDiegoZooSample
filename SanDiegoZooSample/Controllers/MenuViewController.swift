//
//  MenuViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/18/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import WebKit

class MenuViewController: UIViewController {
    
    let topBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let menuWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    var menuToShow: String!
    
    @IBAction func donePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setMenuViews()
        setMenu()
    }
    
    func setMenuViews() {
        // add to subview
        view.addSubview(topBar)
        topBar.addSubview(doneButton)
        view.addSubview(menuWebView)
        
        // set constraints
        NSLayoutConstraint.activate([
            
            // top bar
            topBar.topAnchor.constraint(equalTo: view.topAnchor),
            topBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 80),
            
            // done button
            doneButton.topAnchor.constraint(equalTo: topBar.topAnchor),
            doneButton.leftAnchor.constraint(equalTo: topBar.leftAnchor, constant: 20),
            doneButton.heightAnchor.constraint(equalTo: topBar.heightAnchor),
            doneButton.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            // menu view
            menuWebView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            menuWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuWebView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuWebView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    func setMenu() {
        
        guard let url = Bundle.main.url(forResource: menuToShow, withExtension: "pdf") else {
            showNoMenuFound()
            return
        }
        
        let request = URLRequest(url: url)
        
        menuWebView.load(request)
    }
    
    func showNoMenuFound() {
        let noMenuLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "No Menu Found"
            label.numberOfLines = 0
            
            return label
        }()
        
        view.addSubview(noMenuLabel)
        
        NSLayoutConstraint.activate([
            noMenuLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noMenuLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noMenuLabel.heightAnchor.constraint(equalToConstant: 60),
            noMenuLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
            ])
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
