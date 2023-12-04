//
//  File.swift
//  
//
//  Created by 김인섭 on 12/5/23.
//

import UIKit
import Combine

public extension UIImage {
    
    static func remotePublisher(url: URL) -> AnyPublisher<UIImage?, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
