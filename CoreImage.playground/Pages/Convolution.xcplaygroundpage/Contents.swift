//
//  Convolution.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

// Modifies pixel values by performing a 3x3 matrix convolution.
var filter = CIFilter(name: "CIConvolution3X3", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputWeightsKey: CIVector(values: [
        0, 0, 0,
        0, 1, 0,
        0, 0, 0,
    ]),
    kCIInputBiasKey: 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Modifies pixel values by performing a 5x5 matrix convolution.
filter = CIFilter(name: "CIConvolution5X5", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputWeightsKey: CIVector(values: [
        0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,
    ]),
    kCIInputBiasKey: 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Modifies pixel values by performing a 7x7 matrix convolution.
filter = CIFilter(name: "CIConvolution7X7", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputWeightsKey: CIVector(values: [
        0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0,
    ]),
    kCIInputBiasKey: 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Modifies pixel values by performing a 9-element horizontal convolution.
filter = CIFilter(name: "CIConvolution9Horizontal", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputWeightsKey: CIVector(values: [0, 0, 0, 0, 1, 0, 0, 0, 0]),
    kCIInputBiasKey: 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Modifies pixel values by performing a 9-element vertical convolution.
filter = CIFilter(name: "CIConvolution9Vertical", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputWeightsKey: CIVector(values: [0, 0, 0, 0, 1, 0, 0, 0, 0]),
    kCIInputBiasKey: 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
