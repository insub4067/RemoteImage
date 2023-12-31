//
//  CacheManager.swift
//
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit

actor CacheManager {

    static let shared = CacheManager()
    private init() { }
    
    private let memoryCache = MemoryManager()
    private let diskCache = DiskManager()
}

extension CacheManager {
    
    func setImage(_ image: UIImage, forKey key: String, cacheType: CacheType) {
        switch cacheType {
        case .memory:
            memoryCache.setImage(image, forKey: key)
        case .disk:
            diskCache.setImage(image, forKey: key)
        }
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
#endif
