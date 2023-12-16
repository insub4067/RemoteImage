//
//  GetImageUseCase.swift
//
//
//  Created by 김인섭 on 12/6/23.
//
#if canImport(UIKit)
import UIKit

struct GetImageUseCase {
    
    func execute(
        url: URL?,
        cacheType: CacheType? = .memory,
        resizeWidth: CGFloat? = .none
    ) async throws -> UIImage {
        
        guard let url else { throw RemoteImageError.urlNotFound }
        
        let key = url
            .absoluteString
            .addingPercentEncoding(
                withAllowedCharacters: .urlHostAllowed
            )!
        
        let cacheManager = CacheManager.shared
        let cachedImage = cacheManager.getImage(forKey: key)
        
        if let cachedImage { return cachedImage }
        
        let image = try await UIImage.remote(url: url)
        guard var image else { throw RemoteImageError.imageNotFound }
        
        if let resizeWidth {
            image = image.resized(toWidth: resizeWidth)
        }
        
        if let cacheType {
            cacheManager.setImage(image, forKey: key, cacheType: cacheType)
        }
        return image
    }
}

enum RemoteImageError: Error {
    case imageNotFound, urlNotFound
}
#endif
