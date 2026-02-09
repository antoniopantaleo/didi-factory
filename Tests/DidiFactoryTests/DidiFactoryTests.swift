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
struct DidiFactoryTests {
    
    @Test func resolvesRegisteredService() throws {
        let sut = makeSUT()
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
        let sut = makeSUT()
        
        #expect(throws: ResolutionError<String>.self) {
            _ = try sut.resolve(String.self)
        }
    }
    
    @Test func propertyWrapperWorksThroughAdapter() {
        let sut = makeSUT()
        sut.register { Double.self ~> 9.5 }
        
        @Didi.Injected(in: sut) var value: Double?
        #expect(value == 9.5)
    }
    
    @Test func instanceResolutionIsLazy() throws {
        let sut = makeSUT()
        nonisolated(unsafe) var accessed = false
        
        sut.register {
            String.self ~> {
                accessed = true
                return "Hello DidiFactory"
            }
        }
        
        #expect(accessed == false)
        #expect(try sut.resolve(String.self) == "Hello DidiFactory")
        #expect(accessed == true)
    }
    
    private func makeSUT() -> DidiFactory.FactoryContainer {
        let container = FactoryKit.Container()
        return DidiFactory.FactoryContainer(container: container)
    }
}
