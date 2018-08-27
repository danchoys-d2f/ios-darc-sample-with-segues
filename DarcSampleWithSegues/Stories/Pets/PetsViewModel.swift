//
//  PetsViewModel.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

// This view model does not have a navigator since we cannot
// navigate anywhere from this screen, but it interesting though
// as it controls the view's state using an enumeration and sends
// a pet selection event through delegation. Here we are using the
// delegation pattern, but of course in more complex environments
// one can use functional reactive programming (like RxSwift),
// NotificationCenter or other solutions.

protocol PetsView: class {
    func updateView()
    // Here instead of declaring a navigator capable
    // of only dismissing, we just add this method.
    // It is still better than dismissing right away
    // without notifying the view model, right?
    func dismiss()
}

protocol PetsViewModelDelegate: class {
    func petsViewModel(_ model: PetsViewModel, didSelectPet pet: Pet)
}

class PetsViewModel {
    
    // Notice that we are using an enum as the view state
    // to highlight the fact that our view can be in one
    // of several states.
    enum ViewState {
        case loaded([Pet])
        case loading
        case failedToLoad(Error)
    }
    
    // MARK: - Public properties
    
    unowned let view: PetsView
    
    let petsManager: PetsManager
    
    weak var delegate: PetsViewModelDelegate?
    
    private(set) var state: ViewState {
        didSet {
            view.updateView()
        }
    }
    
    // MARK: - Initialization
    
    init(view: PetsView, petsManager: PetsManager) {
        self.view = view
        self.petsManager = petsManager
        state = .loaded([])
    }
    
    // MARK: - Public API
    
    func onViewDidLoad() {
        view.updateView()
        retrievePets()
    }
    
    func onSelectPet(at index: Int) {
        let pet = state.pets[index]
        delegate?.petsViewModel(self, didSelectPet: pet)
        view.dismiss()
    }
    
    func onCancel() {
        view.dismiss()
    }
    
    // MARK: - Private API
    
    private func retrievePets() {
        state = .loading
        petsManager.retrievePets { (result) in
            switch result {
            case .success(let pets):
                self.state = .loaded(pets)
            case .failure(let error):
                self.state = .failedToLoad(error)
            }
        }
    }

}

extension PetsViewModel.ViewState {
    
    var pets: [Pet] {
        switch self {
        case .loaded(let pets): return pets
        default: return []
        }
    }
    
}
