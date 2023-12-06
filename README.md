# 🛜 RemoteImage

## 🤔 What is RemoteImage?
> You can get image from url and cache easily. 
Support options for cache and animation for Image 

## ✔️ Basic Example
```swift
var imageView = UIImageView() 
let url = URL(string: "https://www......")! // Image URL
imageView.remoteImage(with: url) {
    .init(systemName: "person")! // Placeholder  
}
```

## ✔️ Parameter Example
```swift
var imageView = UIImageView()

let url = URL(string: "https://www......")! // Image URL
let parameter = RemoteImageParamter( // Parameter for Cache and Transition
    cacheType: .disk,
    withAnimation: true,
    duration: 0.2,
    option: .curveEaseIn
)
imageView.remoteImage(with: url, parameter: parameter) {
    .init(systemName: "person")! // Placeholder
}
```
