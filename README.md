# Alexander

[![Carthage Compatible](https://img.shields.io/badge/carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Alexander.svg)](https://cocoapods.org/pods/Alexander)

Alexander is an extremely simple JSON helper written in Swift. It brings type safety and Foundation helpers to the cumbersome task of JSON unpacking.

## Requirements

|  Xcode  |  Swift  |  iOS  |  tvOS  |  OS X  |
| :-----: | :-----: | :---: | :----: | :----: |
| 10.2    | 5.0     | 8.0   | 9.0    | 10.9   |

## Installation

##### [Carthage](https://github.com/carthage/carthage)

> `github "hodinkee/alexander"`

##### [CocoaPods](https://github.com/cocoapods/cocoapods)

> `pod 'Alexander'`

## Usage

### DecoderType

Make a new `DecoderType` that can unpack your object.

```swift
struct User {
    var ID: String
    var name: String
    var email: String
}

struct UserDecoder: DecoderType {
    typealias Value = User
    static func decode(JSON: Alexander.JSON) -> Value? {
        guard
            let ID = JSON["id"]?.stringValue,
            let name = JSON["name"]?.stringValue,
            let email = JSON["email"]?.stringValue
        else {
            return nil
        }
        return User(ID: ID, name: name, email: email)
    }
}
```

Now you can do `let author = JSON["user"]?.decode(UserDecoder)` to get a single user, or `let users = JSON["users"]?.decodeArray(UserDecoder)` to get an array of users.

You can make `DecodableType`s for all kinds of things.

```swift
struct SizeDecoder {
    typealias Value = CGSize
    static func decode(JSON: Alexander.JSON) -> Value? {
        guard
            let width = JSON["width"]?.doubleValue,
            let height = JSON["height"]?.doubleValue
        else {
            return nil
        }
        return CGSize(width: width, height: height)
    }
}
```

Alexander ships with a handful of decoders for common types:

- `DateTimeIntervalSince1970Decoder`
- `DateTimeIntervalSinceReferenceDateDecoder`
- `URLDecoder`
- `RawRepresentableDecoder`

### Nested Objects

Most of Alexander's power comes from its two subscript operators: `subscript[key: String] -> JSON?` and `subscript[index: Int] -> JSON?`. These operators allow you to unpack nested objects without having to refer to each intermediate step by hand. Something like `let nextCursor = JSON["meta"]?["pagination"]?["next_cursor"]?.stringValue` is a single line of code.

### Enums & RawRepresentable

You can also decode anything that conforms to the `RawRepresentable` type. For example, assume the following enum:

```swift
enum Planet: String {
    case Mercury = "mercury"
    case Venus = "venus"
    case Earth = "earth"
    case Mars = "mars"
    case Jupiter = "jupiter"
    case Saturn = "saturn"
    case Uranus = "uranus"
    case Neptune = "neptune"
    // case Pluto = "pluto" =(
}
```

Because `Planet` is backed by a `String` raw value type, it is inheriently `RawRepresentable`. This means you can do `let planet = JSON["planet"]?.decode(RawRepresentableDecoder<Planet>)` or `let planets = JSON["planets"]?.decodeArray(RawRepresentableDecoder<Planet>)`.
