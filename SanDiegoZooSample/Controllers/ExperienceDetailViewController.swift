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
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    // tickets button
    let ticketsButton: UIButton = {
        let button = UIButton(type:.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("tickets", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        
        return button
    }()
    
    // description label
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkText
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
    }
    
    func addConstraints() {
        let navBarHeight = navigationController!.navigationBar.bounds.height
        
        NSLayoutConstraint.activate([
            // experience image
            experienceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: navBarHeight),
            experienceImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            experienceImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            experienceImageView.heightAnchor.constraint(equalToConstant: 180),
            
            // title
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -Size.padding * 2),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.topAnchor.constraint(equalTo: experienceImageView.bottomAnchor, constant: Size.padding),
            
            // tickets
            ticketsButton.heightAnchor.constraint(equalToConstant: 40),
            ticketsButton.widthAnchor.constraint(equalTo: ticketsButton.heightAnchor, multiplier: 3),
            ticketsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Size.padding),
            ticketsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // description
            descriptionLabel.topAnchor.constraint(equalTo: ticketsButton.bottomAnchor, constant: Size.padding
                * 2),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Size.padding),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Size.padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Size.padding)
            ])
        
        if experience.ticketsURL == nil {
            ticketsButton.removeFromSuperview()
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        }
    }
    
    private struct Size {
        static let padding: CGFloat = 16
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
