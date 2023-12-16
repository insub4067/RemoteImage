//
//  UIImage+.swift
//
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit
import Combine

public extension UIImage {
    
    static func remotePublisher(url: URL) -> AnyPublisher<UIImage?, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func remote(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
    
    func resized(toWidth width: CGFloat) -> UIImage {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
#endif
