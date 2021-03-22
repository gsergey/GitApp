//
//  UIImageView+UI.swift
//  Git App
//
//  Created by Sergey Galagan on 21.03.2021.
//

import Foundation
import UIKit

extension UIImageView {
    public func maskCircle() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    public func invertColor() {
        let sourceImage = CIImage(image: self.image!)
        if(sourceImage != nil) {
            if let filter = CIFilter(name: "CIColorInvert") {
                filter.setValue(sourceImage, forKey: kCIInputImageKey)
                let expectedImage = UIImage(ciImage: filter.outputImage!)
                self.image = expectedImage
            }
        } else {
            return
        }
    }
}
