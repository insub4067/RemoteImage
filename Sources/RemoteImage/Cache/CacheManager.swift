//
//  CacheManager.swift
//
//
//  Created by 김인섭 on 12/5/23.
//

import UIKit

class CacheManager {

    static let shared = CacheManager()
    private init() { }
    
    private let memoryCache = MemoryCacheManager()
    private let diskCache = DiskCacheManager()
}

extension CacheManager: ImageCacheable {
    
    func setImage(_ image: UIImage, forKey key: String) {
        memoryCache.setImage(image, forKey: key)
        diskCache.setImage(image, forKey: key)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        if let cachedImage = memoryCache.getImage(forKey: key) {
            return cachedImage
        }
        if let cachedImage = diskCache.getImage(forKey: key) {
            memoryCache.setImage(cachedImage, forKey: key)
            return cachedImage
        }
        return .none
    }
    
    func clearCache() {
        memoryCache.clearCache()
        diskCache.clearCache()
    }
}
