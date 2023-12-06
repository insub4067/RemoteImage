//
//  DiskCacheManager.swift
//
//
//  Created by 김인섭 on 12/5/23.
//
#if canImport(UIKit)
import UIKit

class DiskManager {

    private var directoryPath: URL? {
        FileManager.default
            .urls(
                for: .cachesDirectory,
                in: .userDomainMask
            ).first
    }
}

extension DiskManager: ImageCacheable {

    func setImage(_ image: UIImage, forKey key: String) {
        
        guard let directoryPath = directoryPath else { return }
        let filePath = directoryPath.appendingPathComponent(key)
        
        guard let imageData = image.jpegData(compressionQuality: 1)
        else { return }

        do {
            try imageData.write(to: filePath, options: .atomic)
        } catch {
            print("Error saving image to disk: \(error)")
        }
    }

    func getImage(forKey key: String) -> UIImage? {
        
        guard let directoryPath = directoryPath else { return nil }
        let filePath = directoryPath.appendingPathComponent(key)
        return .init(contentsOfFile: filePath.path)
    }

    func clearCache() {
        guard let directoryPath = directoryPath else { return }

        do {
            let files = try FileManager
                .default
                .contentsOfDirectory(
                    at: directoryPath,
                    includingPropertiesForKeys: nil
                )

            for fileURL in files {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("Error clearing disk cache: \(error)")
        }
    }
}
#endif
