#Alexander

Alexander is an extremely simple JSON helper written in Swift. It brings type safety and Foundation helpers to the cumbersome task of JSON unpacking.

## Installation

[Carthage](https://github.com/carthage/carthage):

```
github "hodinkee/alexander"
```

[CocoaPods](https://github.com/cocoapods/cocoapods):

```
pod "Alexander"
```

## Usage

Make your object conform to the `JSONDecodable` protocol.

```swift
struct Author: JSONDecodable {
    let id: String
    let name: String
    let imageURL: String
    let summary: String?
    let title: String?

    static func decode(JSON: Alexander.JSON) -> Author? {
        if
            let id = JSON["id"]?.string,
            let name = JSON["name"]?.string,
            let imageURL = JSON["avatar_url"]?.string {
                let summary = JSON["description"]?.string
                let title = JSON["title"]?.string
                return Author(id: id, name: name, imageURL: imageURL, summary: summary, title: title)
        }
        return nil
    }
}
```

Now you can do `let author = JSON["author"]?.decode(Author)` to get a single author, or `let authors = JSON["authors"]?.decodeArray(Author)` to get an array of authors.

`JSON` has helpers for extracting dates, numbers, dictionaries, arrays, urls, and strings. You can also unpack nested objects like this: `let nextCursor = JSON["meta"]?["pagination"]?["next_cursor"]?.string`.

You can add `JSONDecodable` to other types as well. Like this:

```swift
extension CGSize: JSONDecodable {
    static func decode(JSON: Alexander.JSON) -> CGSize? {
        if
            let width = JSON["width"]?.object as? CGFloat,
            let height = JSON["height"]?.object as? CGFloat {
                return CGSize(width: width, height: height)
        }
        return nil
    }
}
```

### Enums / RawRepresentable

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
    case Neptune = "Neptune"
    // case Pluto = "pluto" =(
}
```

Because all Swift `enum` are `RawRepresentable`, you can do the following:

```swift
let planet = JSON["planet"]?.decode(Planet)
```

```swift
let planets = JSON["planets"]?.decodeArray(Planet)
```
