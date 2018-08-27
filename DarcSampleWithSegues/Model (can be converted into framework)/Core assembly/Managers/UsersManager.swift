//
//  UsersManager.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import Foundation

class UsersManager: NSObject {
    
    let bundle: Bundle
    
    private(set) lazy var users: [User] = self.readUsers()
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    private func readUsers() -> [User] {
        // Forgive the force-unwraps. This is sample code, remember? :)
        let url = bundle.url(forResource: Constants.usersListFileName, withExtension: nil)!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode([User].self, from: data)
    }

}

private struct Constants {
    static let usersListFileName = "users.plist"
}
