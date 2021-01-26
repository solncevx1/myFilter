//
//  Filters.swift
//  FastNews
//
//  Created by Максим Солнцев on 1/23/21.
//

import Foundation
import UIKit

class ImageFilter {
    
    private var filter: CIFilter!
    lazy private var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    func setFilter(images: [UIImageView], filterKey: FiltersKeys) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.filter = CIFilter(name: filterKey.rawValue)
            
            for image in images {
                let inputImage = CIImage(image: image.image!)
    
                self.filter.setValue(inputImage, forKey: kCIInputImageKey)
                let outputImage =  self.filter.outputImage!
                if let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent) {
                    
                    DispatchQueue.main.async {
                        image.image = UIImage(cgImage: cgImage)
                        
                    }
                }
            }
        }
        
        func cancelFilter(image: UIImage) -> UIImage {
            return image
        }
    }
}
