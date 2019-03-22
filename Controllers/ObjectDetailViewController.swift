//
//  ObjectDetailViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import CoreLocation

private let defaultImage = UIImage(named: "zoo_logo")
private let buttonSpacingWidth: CGFloat = 40

class ObjectDetailViewController: UIViewController {
    
    // base views
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    // content stackView
    let stackView :UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        
        return stackView
    }()
    
    // imageView
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = MyColors.darkGreen.cgColor
        imageView.layer.borderWidth = 4
        
        return imageView
    }()
    
    // view on map button
    let viewOnMapButton: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = MyColors.darkGreen
        button.setTitle("view on map", for: .normal)
        button.addTarget(self, action: #selector(viewOnMapTapped), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // view menu button
    let viewMenuButton: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = MyColors.diningGreen
        button.setTitle("view menu", for: .normal)
        button.addTarget(self, action: #selector(viewMenuTapped), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 40
        
        return stackView
    }()
    
    // status Label
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    // description label
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    var object: ZooObject!
    
    var fromMap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
        setScrollView()
        loadObjectViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isMovingFromParent {
            // revert navigation bar title back to nothing
            navigationItem.title = nil
            
            // set image to nil so doesn't show in segue back to parent
            UIView.animate(withDuration: 0.2, animations: {
                self.imageView.alpha = 0
            }) { _ in
                self.imageView.image = nil
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showObjectOnMapSegue" {
            let destVC = segue.destination as! DetailMapViewController
            destVC.object = sender as? ZooObject
        }
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            statusLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            viewMenuButton.heightAnchor.constraint(equalToConstant: buttonSpacingWidth),
            viewOnMapButton.heightAnchor.constraint(equalToConstant: buttonSpacingWidth),
            
            buttonsStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            buttonsStackView.widthAnchor.constraint(equalToConstant: view.bounds.width - (buttonSpacingWidth * 2)),
            
            summaryLabel.widthAnchor.constraint(equalToConstant: view.bounds.width  - 40),
            summaryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
            ])
    }
    
    func addSubviews() {
        let buttons = [viewMenuButton, viewOnMapButton]
        
        buttons.forEach { buttonsStackView.addArrangedSubview($0) }
        
        let subviews = [imageView, statusLabel, buttonsStackView, summaryLabel]
        
        subviews.forEach { stackView.addArrangedSubview($0) }
    }
    
    func setScrollView() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    func loadObjectViews() {
        
        statusLabel.isHidden = true
        viewMenuButton.isHidden = true
        
        // set navigation bar title
        self.navigationItem.title = object.name
        
        setImage()
        
        summaryLabel.text = object.summary
        
        switch object.type {
        case .animal:
            setAnimalViews()
        case .dining:
            setDiningViews()
        default:
            break
        }
        
        // if segue from map vc
        if fromMap {
            viewOnMapButton.isHidden = true
        }
    }
    
    func setImage() {
        // set image
        guard let imageString = object.imageString else {
            imageView.image = defaultImage
            imageView.contentMode = .scaleAspectFit
            
            return
        }
        
        if let image = UIImage(named: imageString) {
            imageView.image = image
        } else {
            imageView.image = defaultImage
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    func setAnimalViews() {
        let animal = object as! Animal
        
        statusLabel.isHidden = false
        statusLabel.text = animal.conservationStatus.getString()
    }
    
    func setDiningViews() {
        let restaurant = object as! Dining
        
        if restaurant.menuString != nil {
            viewMenuButton.isHidden = false
        }
    }
    
    @objc func viewOnMapTapped() {
        
        performSegue(withIdentifier: "showObjectOnMapSegue", sender: object)
        
    }
    
    @objc func viewMenuTapped() {
        
        let menuController = MenuViewController()
        
        guard let restaurant = object as? Dining else {
            // if not a dining object...
            return
        }
        
        menuController.menuToShow = restaurant.menuString
        
        present(menuController, animated: true, completion: nil)
    }
    
}
