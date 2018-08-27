//
//  PetsManager.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import Foundation

/// This class is initialized with a user object and is responsible
/// for getting the list of pets. In a real-world app instead of the
/// user object being injected directly, it would more likely be an
/// api client class, already configured with that user's session.
class PetsManager: NSObject {
    
    let user: User
    
    let bundle: Bundle
    
    private lazy var allPets: [Pet] = loadPets()
    
    init(user: User, bundle: Bundle) {
        self.user = user
        self.bundle = bundle
    }
    
    func retrievePets(completion: @escaping CompletionBlock<[Pet]>) {
        // At this point I got lazy writing this example, so
        // I will return the same set of pets for every user :D
        let pets = self.allPets
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(pets))
        }
    }
    
    private func loadPets() -> [Pet] {
        let url = bundle.url(forResource: Constants.petsListFileName, withExtension: nil)!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode([Pet].self, from: data)
    }

}

private struct Constants {
    static let petsListFileName = "pets.plist"
}
