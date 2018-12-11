//
//  Sharpen.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Sharpen, luminance
CIFilter.filterNames(inCategory: kCICategorySharpen).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

// Increases image detail by sharpening.
var filter = CIFilter(name: "CISharpenLuminance", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 10.0,
    kCIInputSharpnessKey: 1.6
])!
showImage(filter: filter, extent: inputImage.extent)

// Increases the contrast of the edges between pixels of different colors in an image.
filter = CIFilter(name: "CIUnsharpMask", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 50.0,
    kCIInputIntensityKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
