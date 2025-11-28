//
//  DidiFactoryTests.swift
//  DidiFactory
//
//  Created by Antonio Pantaleo on 27/11/25.
//

import Testing
import Didi
import DidiFactory
import FactoryKit

@Suite
struct DidiFactoryTests: ~Copyable {
    
    deinit {
        FactoryKit.Container.shared.reset(options: .all)
    }
    
    @Test func resolvesRegisteredService() throws {
        let sut = DidiFactory.FactoryContainer()
        sut.register {
            Int.self ~> 21
            String.self ~> "hello"
        }
        
        #expect(try sut.resolve(Int.self) == 21)
        @Didi.Injected(in: sut) var stringValue: String?
        #expect(stringValue == "hello")
    }
    
    @Test func sharesRegistrationsWithProvidedUnderlyingContainer() throws {
        let base = FactoryKit.Container()
        let sut = FactoryContainer(container: base)
        
        sut.register {
            String.self ~> "Hello world!"
        }
        
        // Factory's Resolving API should also see the registration.
        #expect(base.resolve(String.self) != nil)
        #expect(try sut.resolve(String.self) == base.resolve(String.self))
    }
    
    @Test func throwsResolutionErrorWhenServiceMissing() {
        let sut = DidiFactory.FactoryContainer()
        
        #expect(throws: ResolutionError<String>.self) {
            _ = try sut.resolve(String.self)
        }
    }
    
    @Test func propertyWrapperWorksThroughAdapter() {
        let sut = DidiFactory.FactoryContainer()
        sut.register { Double.self ~> 9.5 }
        
        @Didi.Injected(in: sut) var value: Double?
        #expect(value == 9.5)
    }
}
