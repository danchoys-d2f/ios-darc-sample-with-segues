//
//  CoreAssembly.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import Foundation

/// This class contains all the model layer objects, that are meant to be
/// singular in the app. For example, camera manager or location manager.
/// It may also have networking managers, that are not tied to any specific
/// user and are available right after the app launch.
class CoreAssembly: NSObject {
    
    // This is the only singleton you will find in the model layer. This is
    // to let potential utility classes to use this assemblie's managers
    // without having to go through the dependency injection process.
    static let shared = CoreAssembly()

    private(set) lazy var usersManager: UsersManager = UsersManager(bundle: self.bundle)
    
    let bundle: Bundle = Bundle.main
    
    func createAuthenticatedAssembly(user: User) -> AuthenticatedAssembly {
        return AuthenticatedAssembly(user: user, coreAssembly: self)
    }
    
}

// Our managers are not perceiving themselves as singletons. Though it
// may be useful in the real app to have simple access to classes, that
// are singletons by their nature.
extension UsersManager {
    
    class var shared: UsersManager {
        return CoreAssembly.shared.usersManager
    }
    
}
