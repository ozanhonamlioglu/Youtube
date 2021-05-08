//
//  VMImageLoader.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import Foundation
import Combine
import SwiftUI

class VMImageLoader: ObservableObject {
    var imageCache = ImageCache.getImageCache()
    // var didChange = PassthroughSubject<Data, Never>()
    @Published var image: UIImage?

    init(urlString: String) {
        if let img = imageCache.get(forKey: urlString) {
            self.image = img
        } else {
            getImageFromResponse(urlString: urlString)
        }
    }
    
    func getImageFromResponse(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)!
                self.image = image
                self.imageCache.set(forKey: urlString, image: image)
            }
        }
        task.resume()
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
 
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
