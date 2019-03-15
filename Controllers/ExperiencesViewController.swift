//
//  ExperiencesViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class ExperiencesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let zoo = Zoo(name: "San Diego Zoo")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Experiences"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "experienceDetailSegue" {
            let destVC = segue.destination as? ExperienceDetailViewController
            destVC?.experience = sender as? Experience
        }
    }
    
}

extension ExperiencesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return zoo.activitiesArray.count
        case 2:
            return zoo.specialExperiencesArray.count
        case 3:
            return zoo.animalEncountersArray.count
        case 4:
            return zoo.showsArray.count
        case 5:
            return zoo.playAreasArray.count
        default:
            return zoo.zooEducationArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Activities"
        case 2:
            return "Special Experiences"
        case 3:
            return "Animal Encounters"
        case 4:
            return "Shows"
        case 5:
            return "Play Areas"
        default:
            return "Zoo Education"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID: String
        var experience: Experience!
        
        switch indexPath.section {
        case 1:
            experience = zoo.activitiesArray[indexPath.row]
        case 2:
            experience = zoo.specialExperiencesArray[indexPath.row]
        case 3:
            experience = zoo.animalEncountersArray[indexPath.row]
        case 4:
            experience = zoo.showsArray[indexPath.row]
        case 5:
            experience = zoo.playAreasArray[indexPath.row]
        default:
            experience = zoo.zooEducationArray[indexPath.row]
        }
        
        cellID = "ExperienceCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ExperienceTableViewCell
        cell.setExperience(experience: experience)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var experience: Experience?
        
        switch indexPath.section {
        case 1:
            experience = zoo.activitiesArray[indexPath.row]
        case 2:
            experience = zoo.specialExperiencesArray[indexPath.row]
        case 3:
            experience = zoo.animalEncountersArray[indexPath.row]
        case 4:
            experience = zoo.showsArray[indexPath.row]
        case 5:
            experience = zoo.playAreasArray[indexPath.row]
        default:
            experience = zoo.zooEducationArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "experienceDetailSegue", sender: experience)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
