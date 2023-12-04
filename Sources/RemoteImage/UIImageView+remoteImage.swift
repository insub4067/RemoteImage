//
//  UIImageView+.swift
//
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit
import Combine

public extension UIImageView {
    
    func remoteImage(
        with url: URL,
        parameter: RemoteImageParamter = .init(),
        placeholder: (() -> UIImage)? = .none
    ) {
        
        let placeholder = placeholder?()
        if let placeholder { self.image = placeholder }
        
        let key = url
            .absoluteString
            .addingPercentEncoding(
                withAllowedCharacters: .urlHostAllowed
            )!
        
        let cacheManager = CacheManager.shared
        let cachedImage = cacheManager.getImage(forKey: key)
        
        if let cachedImage {
            switch parameter.withAnimation {
            case true:
                self.setImageWithTransition(
                    image: cachedImage,
                    duration: parameter.duration,
                    option: parameter.option
                )
            case false:
                self.image = image
            }
            return
        }
        
        var cancellable: AnyCancellable?
        cancellable = UIImage.remotePublisher(url: url)
            .sink(receiveCompletion: { _ in
                cancellable?.cancel()
            }, receiveValue: { [weak self] image in
                
                guard let self, let image else { return }
                switch parameter.withAnimation {
                case true:
                    self.setImageWithTransition(
                        image: image,
                        duration: parameter.duration,
                        option: parameter.option
                    )
                case false:
                    self.image = image
                }
                
                guard let cacheType = parameter.cacheType else { return }
                cacheManager.setImage(
                    image,
                    forKey: key,
                    cacheType: cacheType
                )
            })
    }
    
    func setImageWithTransition(
        image: UIImage,
        duration: CGFloat,
        option: AnimationOptions
    ) {
        UIView.transition(
            with: self,
            duration: duration,
            options: option,
            animations: { self.image = image },
            completion: nil
        )
    }
}

public enum CacheType {
    case memory, disk
}

public struct RemoteImageParamter {
    
    public let cacheType: CacheType?
    public let withAnimation: Bool
    public let duration: CGFloat
    public let option: UIView.AnimationOptions
    
    public init(
        cacheType: CacheType? = .memory,
        withAnimation: Bool = true,
        duration: CGFloat = 0.2,
        option: UIView.AnimationOptions = .transitionCrossDissolve
    ) {
        self.cacheType = cacheType
        self.withAnimation = withAnimation
        self.duration = duration
        self.option = option
    }
}
#endif
