//
//  Blur.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Blur, such as Gaussian, zoom, motion
CIFilter.filterNames(inCategory: kCICategoryBlur).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

//
var filter = CIFilter(name: "CIBokehBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 20,
    "inputSoftness": 1.0,
    "inputRingSize": 0.1,
    "inputRingAmount": 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Blurs an image using a box-shaped convolution kernel.
filter = CIFilter(name: "CIBoxBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 20
])!
showImage(filter: filter, extent: inputImage.extent)

// TODO: more parameters
let imageUrl = Bundle.main.urlForImageResource("depth.jpg")!
let mainImage = CIImage(contentsOf: imageUrl)!
let disparityImage = CIImage(contentsOf: imageUrl, options: [.auxiliaryDisparity: true])!
filter = CIFilter(name: "CIDepthBlurEffect", parameters: [
    kCIInputImageKey: mainImage,
    kCIInputDisparityImageKey: disparityImage
])!
showImage(filter: filter)

// Blurs an image using a disc-shaped convolution kernel.
filter = CIFilter(name: "CIDiscBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 20
])!
showImage(filter: filter, extent: inputImage.extent)

// Spreads source pixels by an amount specified by a Gaussian distribution.
filter = CIFilter(name: "CIGaussianBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 20
])!
showImage(filter: filter, extent: inputImage.extent)

// Blurs the source image according to the brightness levels in a mask image.
let radialMask = CIFilter(name: "CIRadialGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadius0Key: 100,
    kCIInputRadius1Key: 120,
    kCIInputColor0Key: CIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0)
])!.outputImage!.cropped(to: inputImage.extent)
filter = CIFilter(name: "CIMaskedVariableBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 10,
    "inputMask": radialMask
])!
showImage(filter: filter, extent: inputImage.extent)

// Computes the median value for a group of neighboring pixels and replaces each pixel value with the median.
filter = CIFilter(name: "CIMedianFilter", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter, extent: inputImage.extent)

// morphology: 形态学
// gradient: 梯度
// https://en.wikipedia.org/wiki/Morphological_gradient
filter = CIFilter(name: "CIMorphologyGradient", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 5 // 0 - 50
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CIMorphologyMaximum", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 8 // 0 - 50
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CIMorphologyMinimum", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 8 // 0 - 50
])!
showImage(filter: filter, extent: inputImage.extent)

// Blurs an image to simulate the effect of using a camera that moves a specified angle and distance while capturing the image.
filter = CIFilter(name: "CIMotionBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 20,
    kCIInputAngleKey: 0.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Reduces noise using a threshold value to define what is considered noise.
filter = CIFilter(name: "CINoiseReduction", parameters: [
    kCIInputImageKey: inputImage,
    "inputNoiseLevel": 0.02,
    kCIInputSharpnessKey: 0.40
])!
showImage(filter: filter, extent: inputImage.extent)

// Simulates the effect of zooming the camera while capturing the image.
filter = CIFilter(name: "CIZoomBlur", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 150, y: 150),
    kCIInputAmountKey: 20.0
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
