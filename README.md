# Banana 🍌 🐒 [![Build Status](https://travis-ci.org/bhargavg/Banana.svg?branch=master)](https://travis-ci.org/bhargavg/Banana) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Banana is a library that allows conversion of parsed JSON into typed objects.

Why another JSON mapper right?

The idea behind creating Banana is to show that JSON mapping is not as complicated.

Simplicity and no-black-magic are the key design principles. The name Banana is chosen to signify this.

If you are interested in how this libary has evolved, please read [this blog post series](http://bhargavg.com/swift/2016/03/29/functional-json-parsing-in-swift.html)

## Features
- Error handling through `do-try-catch` mechanism
- Handles Optionals
- Supports Keypaths

## Understanding Version Numbers
`Banana` supports both legacy Swift 2.3 and latest Swift 3.0. To achieve this, the following release strategy is followed:

* Odd number versions for `Swift 2.3` releases
* Even number versions for `Swift 3` releases

## Installation
### [Carthage](https://github.com/Carthage/Carthage)

To add this library to your project, just add the following to your `Cartfile`

```
github "bhargavg/banana"
```

and `carthage update`. For full list of command, please refer [Carthage documentation](https://github.com/Carthage/Carthage).

> Note: Make sure you use even version number releases.

## Examples

### Read a single value
```swift
let value: String = try Banana.load(file: "simple") <~~ keyPath("path.to.key")
```

### Mapping to models and back
```json
[
    {
        "x": "hi",
        "y": 5
    },
    {
        "x": "yolo",
        "yo": 6
    }
]
```

```swift
struct Foo {
    let x: String
    let y: Int

    static func fromJSON(json: JSON) throws -> Foo {
        return Foo(
                    x: try get(json, key: "x"),
                    y: try get(json, keys: ["y", "yo"])
                  )
    }

    static func toJSON(foo: Foo) -> JSON {
        return ["x": foo.x, "y": foo.y]
    }
}

let foos: [Foo] = try Banana.load(file: "foos_file") <<~ Foo.fromJSON
print(foos)

let jsonString: String = try foos <<~ Foo.toJSON <~~ Banana.dump(options: [.PrettyPrinted]) <~~ Banana.toString(encoding: NSUTF8StringEncoding)
print(jsonString)
```

## Todo:
- [x] Carthage Support
- [ ] CocoaPods Support
- [x] SwiftPM Support
- [x] OS X, iOS Targets
- [ ] Watch, TvOS Targets

## Contribution
Found a bug? Want a new feature? Please feel free to report any issue or raise a Pull Request.
