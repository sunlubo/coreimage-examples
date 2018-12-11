//
//  HalftoneEffect.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Halftone effects, such as screen, line screen, hatched
CIFilter.filterNames(inCategory: kCICategoryHalftoneEffect).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

// Simulates a circular-shaped halftone screen.
var filter = CIFilter(name: "CICircularScreen", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputWidthKey: 6.0,
    kCIInputSharpnessKey: 0.7
])!
showImage(filter: filter, extent: inputImage.extent)

// Creates a color, halftoned rendition of the source image, using cyan, magenta, yellow, and black inks over a white page.
filter = CIFilter(name: "CICMYKHalftone", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputWidthKey: 6.0,
    kCIInputAngleKey: 0.0,
    kCIInputSharpnessKey: 0.7,
    "inputGCR": 1.0,
    "inputUCR": 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Simulates the dot patterns of a halftone screen.
filter = CIFilter(name: "CIDotScreen", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputWidthKey: 6.0,
    kCIInputAngleKey: 0.0,
    kCIInputSharpnessKey: 0.7
])!
showImage(filter: filter, extent: inputImage.extent)

// Simulates the hatched pattern of a halftone screen.
filter = CIFilter(name: "CIHatchedScreen", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputWidthKey: 6.0,
    kCIInputAngleKey: 0.0,
    kCIInputSharpnessKey: 0.7
])!
showImage(filter: filter, extent: inputImage.extent)

// Simulates the line pattern of a halftone screen.
filter = CIFilter(name: "CILineScreen", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputWidthKey: 6.0,
    kCIInputAngleKey: 0.0,
    kCIInputSharpnessKey: 0.7
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
