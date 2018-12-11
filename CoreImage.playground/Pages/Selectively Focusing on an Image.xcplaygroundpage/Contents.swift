//
//  Selectively Focusing on an Image.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Focus on a part of an image by applying Gaussian blur and gradient masks.
//
// https://developer.apple.com/documentation/coreimage/selectively_focusing_on_an_image

let inputImage = CIImage(named: "girl")
let width = inputImage.extent.size.width
let height = inputImage.extent.size.height

let topLinearGradient = CIFilter(name: "CILinearGradient", parameters: [
    kCIInputPoint0Key: CIVector(x: 0, y: 0.85 * height),
    kCIInputColor0Key: CIColor(red: 0, green: 1, blue: 0),
    kCIInputPoint1Key: CIVector(x: 0, y: 0.60 * height),
    kCIInputColor1Key: CIColor(red: 0, green: 1, blue: 0, alpha: 0)
])!.outputImage!.cropped(to: inputImage.extent)
showImage(image: topLinearGradient)

let bottomLinearGradient = CIFilter(name: "CILinearGradient", parameters: [
    kCIInputPoint0Key: CIVector(x: 0, y: 0.35 * height),
    kCIInputColor0Key: CIColor(red: 0, green: 1, blue: 0),
    kCIInputPoint1Key: CIVector(x: 0, y: 0.60 * height),
    kCIInputColor1Key: CIColor(red: 0, green: 1, blue: 0, alpha: 0)
])!.outputImage!.cropped(to: inputImage.extent)
showImage(image: bottomLinearGradient)

let gradientMask = CIFilter(name: "CIAdditionCompositing", parameters: [
    kCIInputImageKey: topLinearGradient,
    kCIInputBackgroundImageKey: bottomLinearGradient
])!.outputImage!
showImage(image: gradientMask)

let radialMask = CIFilter(name: "CIRadialGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 0.55 * width, y: 0.6 * height),
    kCIInputRadius0Key: 0.2 * height,
    kCIInputRadius1Key: 0.3 * height,
    kCIInputColor0Key: CIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0)
])!.outputImage!.cropped(to: inputImage.extent)
showImage(image: radialMask)

let maskedVariableBlur = CIFilter(name: "CIMaskedVariableBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 10,
    "inputMask": radialMask
])!
showImage(filter: maskedVariableBlur, extent: inputImage.extent)

//: [Next](@next)
