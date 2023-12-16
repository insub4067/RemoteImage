# 🛜 RemoteImage

## 🤔 What is RemoteImage?
> You can get image from url and cache easily. 
Support options for cache and animation for Image 

## ✔️ Basic SwiftUI Example
```swift
RemoteImage(url) { image in
    image
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .clipShape(Circle())
} placeholder: {
    Image(systemName: "person")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .clipShape(Circle())
}
```

## ✔️ Basic UIKit Example
```swift
var imageView = UIImageView() 
imageView.remoteImage(url) {
    .init(systemName: "person")! // Placeholder  
}
```

## ✔️ Parameter Example
```swift
var imageView = UIImageView()
let url = URL(string: "https://www......")! // Image URL
let parameter = RemoteImageParamter( // Parameter for Cache, Transition, Resize
    cacheType: .disk,
    withAnimation: true,
    duration: 0.2,
    option: .curveEaseIn,
    resizeWidth: 500
)
imageView.remoteImage(with: url, parameter: parameter) {
    .init(systemName: "person")! // Placeholder
}
```
