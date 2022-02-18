


[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# SwiftifyWordPress
<br />
<p align="center">
  <a href="https://github.com/kazi-mifta/SwiftifyWordPress">
    <img src="Readme_Assets/iOSPress_Logo.png" alt="Logo" width="300">
  </a>
  <p align="center">
  </p>
</p>

Turn Your WordPress Website into a Native iOS App. Just Simply add the framework through swift package manager.

<p align="row">
<img src= "Readme_Assets/screen_1.png" width="260" >
<img src= "Readme_Assets/screen_2.png" width="260" >
<img src= "Readme_Assets/screen_3.png" width="260" >
</p>

<p align="row">
<img src= "Readme_Assets/screen_iPadOne.png" width="390" >
<img src= "Readme_Assets/screen_iPadTwo.png" width="390" >
</p>

## Features

- [x] Show all posts of a website through pagination
- [x] In-App browser 
- [x] Search posts([iOS 15 or up](https://developer.apple.com/documentation/swiftui/form/searchable(text:placement:)))
- [x] iPad Support
-  Categorize Posts According to tags

## Techonologies Used

- Swift, SwiftUI
- MVVM
- URLSession(Network Layer)
- Codable(JSON Parsing)


## Requirements

- iOS 13.0+
- Xcode 12.0+

## Installation

#### [Swift Package Manager](https://swift.org/package-manager/)

1. On XCode goto File > Add Packages.
2. On the search bar paste the link: https://github.com/kazi-mifta/SwiftifyWordpress
3. Select "Up to Next Major" with "1.0.0".


#### Manually
Download the files in Sources\SwiftifyWordPress and use the PostListView with your site's URL. Don't forget to add the dependencies. This project requires SDWebImageSwiftUI.
```swift
struct ContentView: View {
    var body: some View {
        // PostsListView(with: PostsData(url: "Your Website's Base URL"))
        PostsListView(with: PostsData(url: "gadgetanalysis.com"))
    }
}
```
## Usage example 
After importing the package you can add the list view of Posts using a single line in your View's Body.
```swift
import SwiftifyWordPress

struct ContentView: View {
    var body: some View {
        //PostsListView(with: PostsData(url: "Your Website's Base URL"))
        PostsListView(with: PostsData(url: "gadgetanalysis.com"))
    }
}
```

## Contribute

I would really appreciate your contribution to **SwiftifyWordPress**. Feel Free to contact with me if you want to contribute or just send a pull request.

## Contact

Kazi Miftahul Hoque – kazimifta13@gmail.com

## License

SwiftifyWordPress is available under the GPLv3 license. See ``LICENSE`` for more information.



[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-GPLv3-blue.svg
[license-url]: LICENSE
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
