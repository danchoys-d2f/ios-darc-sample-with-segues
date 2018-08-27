//
//  Pet.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

struct Pet: Codable {
    
    enum Kind: Int, Codable {
        case cat
        case dog
        case hamster
        // Are there any other animals in the world????
    }
    
    var name: String
    var kind: Kind

}
