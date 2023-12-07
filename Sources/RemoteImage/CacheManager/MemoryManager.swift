//
//  MemoryCacheManager.swift
//  
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit

class MemoryManager {

    private var cacheType = NSCache<NSString, UIImage>()
}

extension MemoryManager: ImageCacheable {
    
    func setImage(_ image: UIImage, forKey key: String) {
        cacheType.setObject(image, forKey: key as NSString)
    }

    func getImage(forKey key: String) -> UIImage? {
        return cacheType.object(forKey: key as NSString)
    }
    
    func clearCache() {
        cacheType.removeAllObjects()
    }
}
#endif
