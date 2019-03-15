//
//  ExperienceDetailViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class ExperienceDetailViewController: UIViewController {
    
    var experience: Experience!
    
    // views
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // imageView
    let experienceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // title label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    // tickets button
    let ticketsButton: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = .blue
        button.setTitle("tickets", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // description label
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScrollView()
        addSubviews()
        addConstraints()
        setViews()
    }
    
    func addSubviews() {
        
        let subviews = [experienceImageView, titleLabel, ticketsButton, descriptionLabel]
        
        subviews.forEach { contentView.addSubview($0) }
    }
    
    func setScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func addConstraints() {
        // experience image
        NSLayoutConstraint.activate([
            experienceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            experienceImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 60),
            experienceImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -60),
            experienceImageView.heightAnchor.constraint(equalToConstant: 120 )
            ])
        
        // title
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.topAnchor.constraint(equalTo: experienceImageView.bottomAnchor, constant: 20)
            ])
        
        // tickets
        NSLayoutConstraint.activate([
            ticketsButton.widthAnchor.constraint(equalToConstant: 80),
            ticketsButton.heightAnchor.constraint(equalToConstant: 40),
            ticketsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            ticketsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        
        // description
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: ticketsButton.bottomAnchor, constant: 40),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        
        if experience.ticketsURL == nil {
            ticketsButton.removeFromSuperview()
//            descriptionLabel.topAnchor.constraint(equalTo: ticketsButton.bottomAnchor, constant: 40).isActive = false
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        }
    }
    
    func setViews() {
        
        // imageView
        if let string = experience.imageString,
            let image = UIImage(named: string) {
            experienceImageView.image = image
        } else {
            experienceImageView.image = UIImage(named: "zoo_logo")!
        }
        
        // title
        titleLabel.text = experience.title
        
        // tickets button
        if experience.ticketsURL != nil {
            setTicketViews()
        }
        
        // description
        descriptionLabel.text = experience.description
    }
    
    func setTicketViews() {
        ticketsButton.addTarget(self, action: #selector(goToTicketsSite), for: .touchUpInside)
    }
    
    @objc func goToTicketsSite() {
        if experience.ticketsURL != "Call to make reservations" {
            openInBrowser(experience.ticketsURL!)
        } else {
            ticketsButton.backgroundColor = .black
        }
    }
}

// Open url in browser with alert asking permission

extension UIViewController {
    func openInBrowser(_ urlString: String) {
        // Set up alert asking whether user wants to open in new browser
        let browserAlert = UIAlertController(title: "Open in Browser?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:])
            }
            NSLog("OK Pressed")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        browserAlert.addAction(okAction)
        browserAlert.addAction(cancelAction)
        self.present(browserAlert, animated: true, completion: nil)
    }
}
