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

## Installation

Only `Carthage` is supported as of now. Adding `CocoaPods` support is in pipeline.

### [Carthage]

[Carthage]: https://github.com/Carthage/Carthage

To add this library to your project, just add the following to your `Cartfile`

```
github "bhargavg/banana"
```

and `carthage update`. For full list of command, please refer [Carthage documentation](https://github.com/Carthage/Carthage)


## Examples

Let's say you a `Foo` struct
```swift
struct Foo {
    let x: String
    let y: Int
}
```

and the following JSON to parse:

```json
{
    "x": "Hi",
    "y": 5
}
```

With Banana, just add a method that takes `JSON` (in this case, `init` method) and get the values using `get` method.

```swift
struct Foo {
    let x: String
    let y: Int

    init(json: JSON) throws {
        x = get(json, key: "x")
        y = get(json, key: "y")
    }
}
```

## Documentation
This library has a very tiny footprint of:
- 4 methods
- 2 Custom Operators
- 1 Type alias

### `get(item: AnyObject)`
All this method does is, try to cast the `item` to a type that caller expects. This will throw error if it couldn't cast.

### `get(box:key:)`
This method will try to retrive the value of `key` from the given dictionary and cast the value to what the caller expects. It can throw errors in two cases:
- If there is no such key (throws `ParseError.NilValue` error)
- If the value couldn't be casted (throws `ParseError.InvalidType` error)

### `get(box:keys:)`
This is similar to above method in functionality, except that now it accepts an array of keys instead of a single key.

### `keyPath(path:)`
This can be used to retrive value of given key path, like, `key1.key2.key3`

### `<~~`
A transformation operator that applies the transformer function (rhs) on the given value (lhs)

### `<<~`
A transformation operator that applies the transformer function (rhs) on each value of given array (rhs)


For detailed usage, please open `Banana.xcworkspace` in Xcode. It contains a sample project along with a Playground.

## Todo:
- [ ] CocoaPods Support
- [ ] SwiftPM Support
- [ ] OSX, Watch, TvOS Targets

## Contribution
Found a bug? Want a new feature? Please feel free to report any issue or raise a Pull Request.
