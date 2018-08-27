//
//  UserDetailsViewModel.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

protocol UserDetailsView: class {
    func updateView()
}

class UserDetailsViewModel {
    
    enum Routes {
        case pets
    }
    
    struct ViewState {
        var userName: String
        var favouritePetName: String?
    }
    
    // MARK: - Public properties
    
    unowned let view: UserDetailsView
    
    let navigator: AnyNavigator<Routes>
    
    let user: User
    
    private(set) var state: ViewState {
        didSet {
            view.updateView()
        }
    }
    
    // MARK: - Initialization
    
    init(view: UserDetailsView, navigator: AnyNavigator<Routes>, user: User) {
        self.view = view
        self.navigator = navigator
        self.user = user
        self.state = ViewState(userName: user.name, favouritePetName: nil)
    }
    
    // MARK: - Public API
    
    func onViewDidLoad() {
        view.updateView()
    }
    
    func onSelectFavouritePet() {
        navigator.navigate(to: .pets)
    }
    
    func onDidSelectFavouritePet(_ pet: Pet) {
        state.favouritePetName = pet.name
    }

}
