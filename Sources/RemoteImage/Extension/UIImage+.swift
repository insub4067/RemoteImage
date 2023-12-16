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
        let scale = width / size.width
        let height = size.height * scale
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        return renderer.image { _ in
            draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
    }
}
#endif
