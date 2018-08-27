//
//  Pet+Extensions.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

extension Pet.Kind {
    
    var localizedName: String {
        // It's not going to be localized in this demo app :D
        switch self {
        case .cat:
            return "Cat"
        case .dog:
            return "Dog"
        case .hamster:
            return "Hamster"
        }
    }
    
}
