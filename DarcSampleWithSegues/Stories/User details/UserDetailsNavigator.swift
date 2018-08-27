//
//  UserDetailsNavigator.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import UIKit

class UserDetailsNavigator: Navigating {
    
    // MARK: - Public properties
    
    unowned let viewController: UserDetailsViewController
    
    // MARK: - Initialization
    
    init(viewController: UserDetailsViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Public API
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueIdentifiers.toPets?:
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.viewControllers[0] as! PetsViewController
            controller.injectDependencies(from: viewController.assembly)
            // After we called injectDependencies, we are sure that the
            // view model and everything is already in place, so...
            controller.viewModel.delegate = self
        default: break
        }
    }
    
    // MARK: - Navigating
    
    func navigate(to destination: UserDetailsViewModel.Routes) {
        switch destination {
        case .pets:
            viewController.performSegue(withIdentifier: SegueIdentifiers.toPets, sender: nil)
        }
    }

}

extension UserDetailsNavigator: PetsViewModelDelegate {
    
    func petsViewModel(_ model: PetsViewModel, didSelectPet pet: Pet) {
        viewController.viewModel.onDidSelectFavouritePet(pet)
    }
    
}

// MARK: - Private declarations -

private struct SegueIdentifiers {
    static let toPets = "To pets"
}

