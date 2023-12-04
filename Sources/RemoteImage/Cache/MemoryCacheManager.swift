//
//  MemoryCacheManager.swift
//  
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit

class MemoryCacheManager {

    private var cache = NSCache<NSString, UIImage>()
}

extension MemoryCacheManager: ImageCacheable {
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
#endif
