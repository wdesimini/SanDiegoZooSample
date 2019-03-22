//
//  AnimalData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation
import UIKit

struct AnimalData {
    
    lazy var animals: Array<Animal> = {
        
        let animalList = [Animal(name: "Komodo Dragon",
                coordinate: CLLocationCoordinate2DMake(32.734035, -117.149512),
                imageString: "komodo_image",
                areaPointer: 0,
                conservationStatus: .threatened,
                summary: "There are over 3,000 lizard species, but the Komodo dragon wins the prize for being the largest living lizard in the world! It is a type of monitor lizard, an ancient reptile species with ancestors that date back more than 100 million years. This awesome creature can grow up to 10 feet (3 meters) long and weigh up to 176 pounds (80 kilograms). A very handsome adult male lives in a specially designed enclosure just outside of our Reptile House. He has indoor and outdoor access, a heated waterbed platform, and gas heaters for warmth, as well as opportunities for his keepers to provide enrichment for him. He is a curious, intelligent, and mild-mannered dragon who comes when his keepers call him. Be sure to check out our juvenile dragons inside the Reptile House. They have the bright colors typical of young Komodo dragons."),
         Animal(name: "African Penguin",
                coordinate: CLLocationCoordinate2DMake(32.736378, -117.152102),
                imageString: "penguin_image",
                areaPointer: 6,
                conservationStatus: .endangered,
                summary: "Whether it’s because of their comical gait, dapper tuxedo-like coloring, or even the males’ legendary parenting skills, the appeal of penguins is undeniable. Guests can see our African penguins—native to the waters and shorelines of southern Africa—at the big, new Dan and Vi McKinney Penguin Habitat at Conrad Prebys Africa Rocks. The spacious Cape Fynbos includes a cobblestone beach, nesting area, and rockwork that mimics the granite boulders found at Boulders Beach in South Africa—along with a 200,000-gallon pool with depths up to 13 feet, and underwater viewing."),
         Animal(name: "Koala",
                coordinate: CLLocationCoordinate2DMake(32.737775, -117.150164),
                areaPointer: 8,
                conservationStatus: .threatened,
                summary: "We never tire of talking about koalas at the San Diego Zoo, ever since we welcomed our first pair, Snugglepot and Cuddlepie, back in 1925. Since then, we have become famous for having the largest koala colony as well as the most successful koala breeding program outside of Australia. Our koalas can be seen from walkways around a Queenslander-style “house” that serves as our koala care center, where you can see keepers preparing eucalyptus browse for the koalas. Because male koalas can be territorial, they have their own perches in one area, while the more social females and their babies, called joeys, share another area. The elevated walkways bring you to eye level with the koalas as they perch in their forest of eucalyptus. Human children can practice their koala-climbing skills on a play structure that features life-size koala sculptures. "),
         Animal(name: "Leopard",
                coordinate: CLLocationCoordinate2DMake(32.737587, -117.150774),
                imageString: "leopard_image",
                areaPointer: 6,
                conservationStatus: .endangered,
                summary: "The leopard is the epitome of stealth. Its very name brings mental pictures of this great spotted cat crouched on a tree limb awaiting the approach of a deer, or of a sleek, spotted body slipping silently through the dry savanna grass with scarcely a ripple as it nears its chosen target. Amur leopards love climbing, exploring, and playing with new things, and have a keen appreciation for scents; keepers add spice oils like cinnamon, spearmint, and lavender to their hay and climbing structures. But, like most cats, they also sleep a lot. You'll find leopards in Africa Rocks and also in Panda Canyon.",
                alternateLocations: [Location(coordinate: CLLocationCoordinate2DMake(32.734608, -117.153194),
                                              areaPointer: 3)]),
         Animal(name: "Giant Panda",
                coordinate: CLLocationCoordinate2DMake(32.735090, -117.152316),
                areaPointer: 3,
                conservationStatus: .threatened,
                summary: "Who can resist the endearing face and lumbering ways of giant pandas? The San Diego Zoo has had a love affair with giant pandas ever since two of them came to visit for 100 days in 1987. In 1996, we worked out an agreement with China to house two adult pandas and their young offspring. We have three giant pandas: Bai Yun and Gao Gao; and Xiao Liwu, born at the Zoo in 2012. Bai Yun and Xiao Liwu can be seen in their habitat at Panda Trek, near the Giant Panda Research Station. Due to age-related health concerns, Gao Gao will remain behind the scenes in the panda habitat. Our Giant Panda Team of keepers and researchers observe and study giant panda biology and behavior, in an effort to learn all we can about these endangered bears. You can watch our pandas daily on Panda Cam, too!"),
         Animal(name: "Giraffe",
                coordinate: CLLocationCoordinate2DMake(32.736937, -117.150252),
                areaPointer: 7,
                conservationStatus: .threatened,
                summary: "Our giraffe exhibit lets you get amazingly close to these tremendously tall creatures. A giraffe could look into a second-story window without even having to stand on its tiptoes! There is only one giraffe species, but there are several subspecies—two of which are endangered. They are distinguished by their coat patterns and by where they live in Africa. For a long time, people called the giraffe a camel-leopard, believing it was a combination of a camel and a leopard! We have Masai giraffes, native to Kenya, with patterns that look like oak leaves. Our giraffes share their space with much smaller Soemmerring’s gazelles, graceful antelope native to Africa. Feeding stations are located throughout, with low feeders containing tasty herbivore pellets lining the front of the exhibit, and much higher ones with leafy acacia branches dangling enticingly in the middle. At either location, it’s so interesting to watch a giraffe wrap its long, dark tongue around its food.")
        ]
        
        return animalList
    }()
    
}
