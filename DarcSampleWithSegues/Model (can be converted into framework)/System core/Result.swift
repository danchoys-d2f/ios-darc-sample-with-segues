//
//  Result.swift
//  DarcSampleWithSegues
//
//  Created by Daniil Konoplev on 27/08/2018.
//  Copyright © 2018 Daniil Konoplev. All rights reserved.
//

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    
    var value: T? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
    
    var isSuccess: Bool {
        return value != nil
    }
    
    // Also map, flatMap, etc...
    
}

typealias CompletionBlock<T> = (Result<T>) -> Void
