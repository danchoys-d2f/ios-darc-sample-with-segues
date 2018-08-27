//
//  UsersViewController.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import UIKit

/// This class serves as an example of a slightly more complicated setup,
/// where we have a view model, but still the view controller plays the navigator
/// role, which makes it is responsible for performing and preparing for segues.

class UsersViewController: UITableViewController, UsersView, Navigating {
    
    // MARK: - Public properties
    
    var assembly: CoreAssembly!
    
    var viewModel: UsersViewModel!
    
    // MARK: - View controller view's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case SegueIdentifiers.toUserDetails?:
            let controller = segue.destination as! UserDetailsViewController
            // Notice that the new view controller will begin a new app domain
            // that requires a new assembly, therefore we are going to create one.
            let user = sender as! User
            let newAssembly = assembly.createAuthenticatedAssembly(user: user)
            controller.injectDependencies(from: newAssembly)
        default: break
        }
    }
    
    // MARK: - Private API
    
    private func setupView() {
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Users view
    
    func updateView() {
        tableView.reloadData()
    }
    
    // MARK: - Navigating
    
    func navigate(to destination: UsersViewModel.Routes) {
        switch destination {
        case .userDetails(let user):
            self.performSegue(withIdentifier: SegueIdentifiers.toUserDetails, sender: user)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellReuseIdentifier, for: indexPath)
        let user = viewModel.state.users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onSelectUser(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension UsersViewController: AutoInjecting {
    
    func injectDependencies(from fromObject: CoreAssembly) {
        self.assembly = fromObject
        self.viewModel = UsersViewModel(
            view: self, navigator: self.toWeakNavigator(), // Notice that we cast using the weak variant!
            usersManager: fromObject.usersManager
        )
    }
    
}

// MARK: - Private declarations -

private struct Constants {
    static let userCellReuseIdentifier = "User cell"
}

private struct SegueIdentifiers {
    static let toUserDetails = "To user details"
}

