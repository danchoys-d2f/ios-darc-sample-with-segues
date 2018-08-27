//
//  WelcomeViewController.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import UIKit

// This is the very beginning of our user interface. I personally prefer to
// have a never-changing root view controller (usually a custom container
// controller) instead of changing the window's rootViewController property.
// Such view controller will become the original owner of the core assembly.

// This view controller is rather small, so it has no need for a view model,
// navigator or anything. It's a good-old MVC view controller, yet not massive.

class WelcomeViewController: UIViewController {

    // MARK: - Public properties
    
    var assembly: CoreAssembly = CoreAssembly.shared
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case SegueIdentifiers.toUsers?:
            let controller = segue.destination as! UsersViewController
            // Since our UsersViewController is adopting AutoInjecting,
            // we can write simply the following and the method will take
            // care of the dependency injection.
            controller.injectDependencies(from: assembly)
        default: break
        }
    }

}

// MARK: - Private declarations -

private struct SegueIdentifiers {
    static let toUsers = "To users"
}

