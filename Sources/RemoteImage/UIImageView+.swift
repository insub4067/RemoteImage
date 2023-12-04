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
        withAnimation: Bool = true,
        duration: CGFloat = 0.2,
        option: AnimationOptions = .transitionCrossDissolve,
        placeholder: (() -> UIImage)? = .none
    ) {
        
        let placeholder = placeholder?()
        if let placeholder { self.image = placeholder }
        
        let key = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let cache = CacheManager.shared
        
        if let cachedImage = cache.getImage(forKey: key) {
            if withAnimation {
                self.setImageWithTransition(
                    image: cachedImage,
                    duration: duration,
                    option: option
                )
            } else {
                self.image = cachedImage
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
                if withAnimation {
                    self.setImageWithTransition(
                        image: image,
                        duration: duration,
                        option: option
                    )
                } else {
                    self.image = image
                }
                cache.setImage(image, forKey: key)
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
#endif
