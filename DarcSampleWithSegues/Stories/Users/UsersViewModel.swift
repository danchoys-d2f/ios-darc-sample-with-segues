//
//  UsersViewModel.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

protocol UsersView: class {
    func updateView()
}

class UsersViewModel {
    
    enum Routes {
        case userDetails(User)
    }
    
    struct ViewState {
        var users: [User]
    }
    
    // MARK: - Public properties
    
    unowned let view: UsersView
    
    let navigator: AnyNavigator<Routes>
    
    let usersManager: UsersManager
    
    private(set) var state: ViewState {
        didSet {
            view.updateView()
        }
    }
    
    // MARK: - Initialization
    
    init(view: UsersView, navigator: AnyNavigator<Routes>, usersManager: UsersManager) {
        self.view = view
        self.navigator = navigator
        self.usersManager = usersManager
        self.state = ViewState(users: [])
    }
    
    // MARK: - Public API
    
    func onViewDidLoad() {
        state.users = usersManager.users
    }

    func onSelectUser(at index: Int) {
        let user = state.users[index]
        navigator.navigate(to: .userDetails(user))
    }
    
}
