//
//  UserDetailsViewController.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import UIKit

class UserDetailsViewController: UITableViewController, UserDetailsView {

    // MARK: - Public properties
    
    var viewModel: UserDetailsViewModel!
    
    var assembly: AuthenticatedAssembly!
    
    var navigator: UserDetailsNavigator!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var userNameLabel: UILabel!
    
    @IBOutlet private weak var petNameLabel: UILabel!
    
    // MARK: - Private properties
    
    // MARK: - View controller view's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        navigator.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Actions
    
    @IBAction private func selectFavouritePet(_ sender: Any) {
        viewModel.onSelectFavouritePet()
    }
    
    // MARK: - Private API
    
    // MARK: - User details view
    
    func updateView() {
        userNameLabel.text = viewModel.state.userName
        petNameLabel.text = viewModel.state.favouritePetName ?? "???"
    }

}

extension UserDetailsViewController: AutoInjecting {
    
    func injectDependencies(from fromObject: AuthenticatedAssembly) {
        self.assembly = fromObject
        self.navigator = UserDetailsNavigator(viewController: self)
        self.viewModel = UserDetailsViewModel(
            view: self, navigator: self.navigator.toAnyNavigator(),
            user: fromObject.user
        )
    }
    
}

