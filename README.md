<h1>Glacid <img src="https://github.com/user-attachments/assets/2660dbc2-4bd9-4653-8584-166c0d8279a4" align="right" width="102"/></h1>

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/github/v/release/ericviana/Glacid?include_prereleases)](https://github.com/ericviana/Glacid/releases)
[![License](https://img.shields.io/github/license/ericviana/Glacid)](https://github.com/ericviana/Glacid/blob/main/LICENSE)

Glacid is a SwiftUI package that provides a modifier to add glass-like textures to views. The effect includes blur, transparency, and light effects that respond to the phone's pitch, yaw, and roll.

## **Installation**

Add the following to your `Package.swift` file:

### Swift Package Manager

1. In Xcode, navigate to **File > Add Packages...**
2. Enter the repository URL:

```
https://github.com/ericviana/Glacid
```

3. Select "Up to Next Major Version" and click **Add Package**.

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ericviana/Glacid.git", from: "0.0.1")
]
```

## **Usage**

To apply the glass-like effect to a view, just use the `.glacid()` modifier:

```swift
struct ContentView: View {
    var body: some View {
        Button("Tap me") {
            print("Button tapped")
        }
        .glacid()
    }
}
```

## **Contributing**

Contributions are welcome! Here's how you can help:

- Reporting bugs
- Suggesting improvements
- Adding new features
- Writing documentation
- Creating examples
- Fixing typos

For bug reports and feature requests, please use the GitHub Issues section.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
