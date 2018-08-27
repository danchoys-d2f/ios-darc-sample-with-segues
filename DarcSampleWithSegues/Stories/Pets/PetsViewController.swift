//
//  PetsViewController.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import UIKit

class PetsViewController: UITableViewController, PetsView {
    
    // MARK: - Public properties
    
    var assembly: AuthenticatedAssembly!
    
    var viewModel: PetsViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    @IBOutlet private var backgroundView: UIView!
    
    // MARK: - Private properties
    
    // MARK: - View controller view's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.onViewDidLoad()
    }
    
    // MARK: - Navigation
    
    // MARK: - Actions
    
    @IBAction private func cancel(_ sender: Any) {
        viewModel.onCancel()
    }
    
    // MARK: - Private API
    
    private func setupView() {
        tableView.backgroundView = backgroundView
    }
    
    // MARK: - Pets view
    
    func updateView() {
        tableView.backgroundView?.isHidden = viewModel.state.isLoaded
        activityIndicatorView.isHidden = !viewModel.state.isLoading
        errorLabel.isHidden = !viewModel.state.hasFailed
        if viewModel.state.isLoading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
        tableView.reloadData()
    }
    
    func dismiss() {
        presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.pets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.petCellReuseIdentifier, for: indexPath)
        let pet = viewModel.state.pets[indexPath.row]
        cell.textLabel?.text = pet.name
        cell.detailTextLabel?.text = pet.kind.localizedName
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onSelectPet(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension PetsViewController: AutoInjecting {
    
    func injectDependencies(from fromObject: AuthenticatedAssembly) {
        self.assembly = fromObject
        self.viewModel = PetsViewModel(view: self, petsManager: fromObject.petsManager)
    }
    
}

// MARK: - Private declarations -

private extension PetsViewModel.ViewState {
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var isLoaded: Bool {
        switch self {
        case .loaded: return true
        default: return false
        }
    }
    
    var hasFailed: Bool {
        switch self {
        case .failedToLoad: return true
        default: return false
        }
    }
    
}

private struct Constants {
    static let petCellReuseIdentifier = "Pet cell"
}
