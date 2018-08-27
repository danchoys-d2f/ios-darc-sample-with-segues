//
//  Navigating.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

/// Base protocol that defines objects, capable of performing navigation
/// tasks. Associated type is usually a enum that defines all the routes
/// that may be taken from a particular scene.
protocol Navigating {
    associatedtype Routes
    func navigate(to destination: Routes)
}

/// Type erasing structure, that allows to hide concrete types, adopting
/// the Navigating protocol, behind a single interface that also adopts
/// the Navigating protocol.
struct AnyNavigator<T>: Navigating {
    
    let navigateBlock: (T) -> Void
    
    init<U: Navigating>(strongNavigator navigator: U) where U.Routes == T {
        navigateBlock = navigator.navigate(to:)
    }
    
    init<U: Navigating & AnyObject>(unownedNavigator navigator: U) where U.Routes == T {
        navigateBlock = { [unowned navigator] destination in
            navigator.navigate(to: destination)
        }
    }
    
    func navigate(to destination: T) {
        navigateBlock(destination)
    }
    
}

extension Navigating {
    
    /// Converts a navigator into a type-erased version.
    func toAnyNavigator() -> AnyNavigator<Routes> {
        return AnyNavigator(strongNavigator: self)
    }
    
}

extension Navigating where Self: AnyObject {
    
    /// Converts a navigator into a type-erased version.
    /// Keeps an unowned reference back to original navigator
    /// to work around the reference cycle issue.
    func toWeakNavigator() -> AnyNavigator<Routes> {
        return AnyNavigator(unownedNavigator: self)
    }
    
}


