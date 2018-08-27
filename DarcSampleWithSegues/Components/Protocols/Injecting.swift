//
//  Injecting.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

import UIKit

/// This protocol defines an object that is capable of injecting
/// dependencies from objects of type FromType into objects of type
/// ToType.
protocol Injecting {
    associatedtype FromType
    associatedtype ToType
    func injectDependencies(from fromObject: FromType, into toObject: ToType)
}

/// This protocol defines an object, that is capable of injecting
/// dependencies from objects of type FromType into itself.
protocol AutoInjecting {
    associatedtype FromType
    func injectDependencies(from fromObject: FromType)
}

/// A type erasing structure, that allows to hide different types, adopting
/// the Injecting protocol behind a single interface, that also adopts that
/// protocol.
struct AnyInjector<T, K>: Injecting {
    
    let injectionBlock: (T, K) -> Void
    
    init<U: Injecting>(_ injector: U) where U.FromType == T, U.ToType == K {
        self.injectionBlock = injector.injectDependencies(from:into:)
    }
    
    init(injectionBlock: @escaping (T, K) -> Void) {
        self.injectionBlock = injectionBlock
    }
    
    func injectDependencies(from fromObject: T, into toObject: K) {
        injectionBlock(fromObject, toObject)
    }
    
}

extension Injecting {
    
    /// Converts any injector into a type-erased version
    func toAnyInjector() -> AnyInjector<FromType, ToType> {
        return AnyInjector(self)
    }
    
}

extension AutoInjecting {
    
    /// Returns an injector, that uses the method, provided by the AutoInjecting
    /// protocol for injection. Obviously, it works only for the objects of type
    /// AutoInjecting.FromType.
    var defaultInjector: AnyInjector<FromType, Self> {
        return AnyInjector { from, to in
            to.injectDependencies(from: from)
        }
    }
    
}
