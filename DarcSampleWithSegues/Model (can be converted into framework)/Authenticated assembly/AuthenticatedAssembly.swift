//
//  AuthenticatedAssembly.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import Foundation

class AuthenticatedAssembly: NSObject {
    
    let user: User
    
    let coreAssembly: CoreAssembly
    
    private(set) lazy var petsManager: PetsManager = PetsManager(user: self.user, bundle: self.coreAssembly.bundle)
    
    // We could have listed all the objects required by this assembly
    // in the constructor instead of specifying the user, but as the
    // project grows, this constructor may go completely bananas.
    init(user: User, coreAssembly: CoreAssembly) {
        self.user = user
        self.coreAssembly = coreAssembly
    }
    
}
