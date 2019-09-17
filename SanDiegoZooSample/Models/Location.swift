//
//  Location.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation

//enum Location: Hashable {
//    case point(latitude: Double, longitude: Double)
//}
//
//extension Location: Decodable {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        if let locationPoints = try? container.decode(Array<Double>.self, forKey: .point), locationPoints.count == 2 {
//            self = .point(latitude: locationPoints[0], longitude: locationPoints[1])
//            return
//        }
//        
//        throw DecodingError.keyNotFound(CodingKeys.point, DecodingError.Context(codingPath: [CodingKeys.point], debugDescription: "Failed decoding Location"))
//    }
//}
//
//extension Location: Encodable {
//    enum CodingKeys: CodingKey {
//        case point
//        //case region
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        switch self {
//        case .point(let latitude, let longitude):
//            try container.encode([latitude, longitude], forKey: .point)
//        }
//    }
//}
