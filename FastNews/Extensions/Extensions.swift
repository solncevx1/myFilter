//
//  Extensions.swift
//  FastNews
//
//  Created by Максим Солнцев on 1/23/21.


import Foundation
import UIKit

extension UIImage {

    func setMono() -> UIImage {
        guard let imageCI = CIImage(image: self) else { return self }
        func setFilter(_ input: CIImage) -> CIImage? {
            let bloomFilter = CIFilter(name:"CIPhotoEffectInstant")
               bloomFilter?.setValue(input, forKey: kCIInputImageKey)

            return bloomFilter?.outputImage
        }
        guard let filteredImage = setFilter(imageCI) else { return self }
        let newImage = UIImage(ciImage: filteredImage)
        return newImage

    }

    func setTonal() -> UIImage {

        guard let imageCI = CIImage(image: self) else { return self }

        func setFilter(_ input: CIImage) -> CIImage? {
            let bloomFilter = CIFilter(name:"CIPhotoEffectTonal")
               bloomFilter?.setValue(input, forKey: kCIInputImageKey)
            
            return bloomFilter?.outputImage
        }
        guard let filteredImage = setFilter(imageCI) else { return self }
        let newImage = UIImage(ciImage: filteredImage)
        return newImage

    }

    func setNoir() -> UIImage {
        guard let imageCI = CIImage(image: self) else { return self }

        func setFilter(_ input: CIImage) -> CIImage? {
            let sepiaFilter = CIFilter(name:"CIPhotoEffectNoir")
            sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
            
            return sepiaFilter?.outputImage
        }
        guard let filteredImage = setFilter(imageCI) else { return self }
        let newImage = UIImage(ciImage: filteredImage)
        return newImage
    }
}
