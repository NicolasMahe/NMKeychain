# NMKeychain

[![CI Status](http://img.shields.io/travis/nicolas@mahe.me/NMKeychain.svg?style=flat)](https://travis-ci.org/nicolas@mahe.me/NMKeychain)
[![Version](https://img.shields.io/cocoapods/v/NMKeychain.svg?style=flat)](http://cocoapods.org/pods/NMKeychain)
[![License](https://img.shields.io/cocoapods/l/NMKeychain.svg?style=flat)](http://cocoapods.org/pods/NMKeychain)
[![Platform](https://img.shields.io/cocoapods/p/NMKeychain.svg?style=flat)](http://cocoapods.org/pods/NMKeychain)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

NMKeychain is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NMKeychain"
```

## Usage

Init the `NMKeychain` object

```swift
let dataInKeychain = NMKeychain<Date?>(
  key: "dataInKeychain_unique_key",
  identifier: "unique_keychain_identifier",
  label: "Label for this data",
  defaultValue: Date(timeIntervalSinceNow: -600),
  synchronizable: true,
  accessibility: .afterFirstUnlock,
  onChange: {
    print("data has changed")
  }
)
```

Set a value

```swift
dataInKeychain.value = Date()
```

Get the value

```swift
let date = dataInKeychain.value
```

## Author

Nicolas Mahe, nicolas@mahe.me

## Dependancy

[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) from Kishikawakatsumi

## License

NMKeychain is available under the MIT license. See the LICENSE file for more info.
