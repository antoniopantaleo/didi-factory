//
//  FactoryContainer.swift
//  DidiFactory
//
//  Created by Antonio Pantaleo on 27/11/25.
//

import Didi
import FactoryKit

// Extend Factory's default container to opt into the Resolving API, which provides
// dynamic registrations without declaring dedicated Factory properties.
extension FactoryKit.Container: FactoryKit.Resolving {}

/// A `Container` adapter backed by the Factory dependency injection framework.
public final class FactoryContainer: Didi.Container {
    
    private let container: any FactoryKit.Resolving
    
    /// Creates a new adapter around a Factory container.
    /// - Parameter container: The underlying Factory container to use. Defaults to a fresh container instance.
    public init(container: any FactoryKit.Resolving = FactoryKit.Container.shared) {
        self.container = container
    }
    
    /// Stores a registration in the underlying Factory container.
    /// - Parameter component: A closure producing the registration to store.
    public func register<P>(_ component: () -> Registration<P>) where P: Sendable {
        let registration = component()
        _ = container.register(registration.type, factory: registration.factory)
    }
    
    /// Resolves a service from the underlying Factory container, translating missing services into `ResolutionError`.
    /// - Parameter type: The type to resolve.
    /// - Returns: An instance of the requested type.
    public func resolve<P>(_ type: P.Type) throws(ResolutionError<P>) -> P {
        guard let resolved = container.resolve(type) else {
            throw ResolutionError(type: type)
        }
        return resolved
    }
}
