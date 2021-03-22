//
//  UIImageView+Cache.swift
//  Git App
//
//  Created by Sergey Galagan on 20.03.2021.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, UIImage>()


extension UIImageView {
    func loadCachedImageFromURLString(_ URLString: String, placeholder: UIImage?, complitionBlock: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.image = nil
            if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
                self.image = cachedImage
                complitionBlock();
                return
            }
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(">>>>>>>>> ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeholder
                    }
                    complitionBlock();
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                            complitionBlock();
                        }
                    }
                }
            }).resume()
        }
    }
}
