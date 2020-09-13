# iOSPress

Turn Your WordPress Website into a Native iOS App. Just Simply add the framework through swift package manager.

## Usage
Just add your website's baseUrl into the PostListView Struct of SwiftUI and you are done. All your post's will be shown as List inside a Navigatoin View.


```swift
struct ContentView: View {
    var body: some View {
        // PostsListView(baseUrl: "Your Website's Base URL")
        PostsListView(baseUrl: "gadgetanalysis.com")
    }
}
```
