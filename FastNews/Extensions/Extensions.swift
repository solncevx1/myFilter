//
//  Extensions.swift
//  FastNews
//
//  Created by Максим Солнцев on 1/23/21.


import Foundation
import UIKit

extension UIImage {

    func setTonar() -> UIImage {
        guard let imageCI = CIImage(image: self) else { return self }
        func setFilter(_ input: CIImage) -> CIImage? {
            let bloomFilter = CIFilter(name:"CIPhotoEffectMono")
               bloomFilter?.setValue(input, forKey: kCIInputImageKey)

            return bloomFilter?.outputImage
        }
        guard let filteredImage = setFilter(imageCI) else { return self }
        let newImage = UIImage(ciImage: filteredImage)
        return newImage

    }

    func setBlur() -> UIImage {

        guard let imageCI = CIImage(image: self) else { return self }

        func setFilter(_ input: CIImage, intensity: Double) -> CIImage? {
            let bloomFilter = CIFilter(name:"CIVignetteEffect")
               bloomFilter?.setValue(input, forKey: kCIInputImageKey)
               bloomFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
            return bloomFilter?.outputImage
        }
        guard let filteredImage = setFilter(imageCI, intensity: 0.9) else { return self }
        let newImage = UIImage(ciImage: filteredImage)
        return newImage

    }

    func setSepia() -> UIImage {
        guard let imageCI = CIImage(image: self) else { return self }

        func setFilter(_ input: CIImage, intensity: Double) -> CIImage? {
            let sepiaFilter = CIFilter(name:"CISepiaTone")
            sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
            sepiaFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
            return sepiaFilter?.outputImage
        }
        guard let filteredImage = setFilter(imageCI, intensity: 0.9) else { return self }
        let newImage = UIImage(ciImage: filteredImage)
        return newImage
    }
}
