# RemoteImage

## Example
```swift
var imageView = UIImageView()

let url = URL(string: "https://www......")! // Remote Image URL
let parameter = RemoteImageParamter( // Parameter for Options
    cacheType: .disk,
    withAnimation: true,
    duration: 0.2,
    option: .curveEaseIn
)
imageView.remoteImage(with: url, parameter: parameter) {
    .init(systemName: "person")! // PlaceholderImage
}
```
