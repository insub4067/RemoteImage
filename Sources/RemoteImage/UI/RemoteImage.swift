//
//  RemoteImage.swift
//
//
//  Created by 김인섭 on 12/6/23.
//
#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15.0, *)
public struct RemoteImage<Content: View, Placeholder: View>: View {
    
    private let useCase = GetImageUseCase()
    
    private let url: URL?
    private let parameter: RemoteImageParamter
    private let content: (Image) -> Content
    private let placeholder: Placeholder
    
    @State private  var image: UIImage? = .none
    
    public init(
        _ url: URL?,
        parameter: RemoteImageParamter = .init(),
        content: @escaping (Image) -> Content,
        placeholder: () -> Placeholder
    ) {
        self.url = url
        self.parameter = parameter
        self.content = content
        self.placeholder = placeholder()
    }
    
    public var body: some View {
        Group {
            if let image {
                content(Image(uiImage: image))
            } else {
                placeholder
            }
        }.task {
            let image = try? await useCase.execute(url: url, cacheType: parameter.cacheType)
            switch parameter.withAnimation {
            case true:
                let animation = Animation.easeInOut(duration: parameter.duration)
                withAnimation(animation) {
                    self.image = image
                }
                withAnimation { self.image = image }
            case false:
                self.image = image
            }
        }
    }
}
#endif
