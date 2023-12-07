//
//  ImageCacheable.swift
//  
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit

protocol ImageCacheable {
    
    func setImage(_ image: UIImage, forKey key: String)
    
    func getImage(forKey key: String) -> UIImage?
    
    func clearCache()
}
#endif
