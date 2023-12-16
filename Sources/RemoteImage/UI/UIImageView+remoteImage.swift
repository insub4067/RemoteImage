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
        _ url: URL,
        parameter: RemoteImageParamter = .init(),
        placeholder: (() -> UIImage)? = .none
    ) {
        
        let placeholder = placeholder?()
        if let placeholder { self.image = placeholder }
        
        Task {
            let usecase = GetImageUseCase()
            let image = try await usecase.execute(url: url)
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
        }
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
    public let resizeWidth: CGFloat?
    
    public init(
        cacheType: CacheType? = .memory,
        withAnimation: Bool = true,
        duration: CGFloat = 0.2,
        option: UIView.AnimationOptions = .transitionCrossDissolve,
        resizeWidth: CGFloat? = .none
    ) {
        self.cacheType = cacheType
        self.withAnimation = withAnimation
        self.duration = duration
        self.option = option
        self.resizeWidth = resizeWidth
    }
}
#endif
