# DidiFactory

[![Swift 6.2](https://img.shields.io/badge/Swift-6.2-orange.svg)](https://swift.org)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-6DB33F.svg)](https://www.swift.org/package-manager/)

![Platform macOS](https://img.shields.io/badge/platform-macOS%2010.15%2B-lightgrey.svg)
![Platform iOS](https://img.shields.io/badge/platform-iOS%2013%2B-lightgrey.svg)
![Platform tvOS](https://img.shields.io/badge/platform-tvOS%2013%2B-lightgrey.svg)
![Platform watchOS](https://img.shields.io/badge/platform-watchOS%208%2B-lightgrey.svg)
![Platform visionOS](https://img.shields.io/badge/platform-visionOS%201%2B-lightgrey.svg)

`didi-factory` is a [Factory](https://github.com/hmlongco/Factory) adapter for [didi](https://github.com/antoniopantaleo/didi)

## Installation

### Swift Package Manager

Add `didi` to your dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/antoniopantaleo/didi-factory.git", from: "3.0.0")
]
```

Then depend on the products you need:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "DidiFactory", package: "didi-factory")
    ]
)
```

## Quick start

Here's a brief look on how `didi-factory` API looks like:

### Registration

You can register a service to a type using the special `~>` syntax, listing all of your injections like this:

```swift
import DidiFactory

let container = FactoryContainer()

container.register {
    Int.self ~> 2
    HTTPClient.self ~> URLSessionHTTPClient(session: .shared)
    String.self ~> {
        var result = "Hello"
        result += ", Didi"
        return result
    }
}
```

> [!NOTE]
> You do not need to write commas within the registration closure

## Contributing

Issues and pull requests are welcome. Feel free to contribute!


