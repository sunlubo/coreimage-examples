//
//  Custom.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

CIFilter.registerName("VintageVignette", constructor: CustomFiltersVendor(), classAttributes: [
    kCIAttributeFilterCategories: [
        kCICategoryVideo, kCICategoryStillImage, kCICategoryNonSquarePixels, kCICategoryInterlaced
    ]
])

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let filter = CIFilter(name: "VintageVignette", parameters: [
    kCIInputImageKey: inputImage,
    "inputVignetteIntensity": 1,
    "inputVignetteRadius": 1,
    "inputSepiaToneIntensity": 1
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
