//
//  ExperienceType.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

enum ExperienceType {
    case special, zooEducation, activity, animalEncounter, show, playArea, unknown
}

// Experience Subclasses

class SpecialExperience: Experience {
    
    override var type: ExperienceType {
        get {
            return .special
        }
    }
}

class ZooEducation: Experience {
    override var type: ExperienceType {
        get {
            return .zooEducation
        }
    }
}

class Activity: Experience {
    override var type: ExperienceType {
        get {
            return .activity
        }
    }
}

class AnimalEncounter: Experience {
    
    override var type: ExperienceType {
        get {
            return .animalEncounter
        }
    }
}

class Show: Experience {
    
    override var type: ExperienceType {
        get {
            return .show
        }
    }
}

class PlayArea: Experience {
    
    override var type: ExperienceType {
        get {
            return .playArea
        }
    }
}
