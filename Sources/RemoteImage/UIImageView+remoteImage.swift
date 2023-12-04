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
        cache: CacheType? = .memory,
        withAnimation: Bool = true,
        duration: CGFloat = 0.2,
        option: AnimationOptions = .transitionCrossDissolve,
        placeholder: (() -> UIImage)? = .none
    ) {
        
        let placeholder = placeholder?()
        if let placeholder { self.image = placeholder }
        
        let key = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let cacheManager = CacheManager.shared
        let cachedImage = cacheManager.getImage(forKey: key)
        
        if let cachedImage {
            switch withAnimation {
            case true:
                self.setImageWithTransition(
                    image: image,
                    duration: duration,
                    option: option
                )
            case false:
                self.image = image
            }
            return
        }
      
        var cancellable: AnyCancellable?
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                cancellable?.cancel()
            }, receiveValue: { [weak self] image in
                guard let self = self, let image = image else { return }
                
                switch withAnimation {
                case true:
                    self.setImageWithTransition(
                        image: image,
                        duration: duration,
                        option: option
                    )
                case false:
                    self.image = image
                }
                
                guard let cache else { return }
                cacheManager.setImage(
                    image,
                    forKey: key,
                    cache: cache
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
#endif
