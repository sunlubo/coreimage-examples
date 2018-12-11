//
//  ColorAdjustment.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Color adjustment, such as gamma adjust, white point adjust, exposure
CIFilter.filterNames(inCategory: kCICategoryColorAdjustment).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage)

// Modifies color values to keep them within a specified range.
//
// At each pixel, color component values less than those in inputMinComponents will be increased to match those in inputMinComponents,
// and color component values greater than those in inputMaxComponents will be decreased to match those in inputMaxComponents.
var filter = CIFilter(name: "CIColorClamp", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputMinComponentsKey: CIVector(x: 0.2, y: 0.4, z: 0.6, w: 0.0),
    kCIInputMaxComponentsKey: CIVector(x: 0.4, y: 0.6, z: 0.8, w: 1.0)
])!
showImage(filter: filter)

// Adjusts saturation, brightness, and contrast values.
filter = CIFilter(name: "CIColorControls", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputSaturationKey: 1.0,
    kCIInputBrightnessKey: 1.0,
    kCIInputContrastKey: 3.0
])!
showImage(filter: filter)

// Multiplies source color values and adds a bias factor to each color component.
filter = CIFilter(name: "CIColorMatrix")!
filter.setValue(inputImage, forKey: kCIInputImageKey)
filter.setValue(CIVector(x: 0.6, y: 0.3, z: 0.1, w: 0.0), forKey: "inputRVector")
filter.setValue(CIVector(x: 0.2, y: 0.7, z: 0.1, w: 0.0), forKey: "inputGVector")
filter.setValue(CIVector(x: 0.2, y: 0.3, z: 0.4, w: 0.0), forKey: "inputBVector")
filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 1.0), forKey: "inputAVector")
filter.setValue(CIVector(x: 73.3 / 255, y: 73.3 / 255, z: 73.3 / 255, w: 0), forKey: "inputBiasVector")
showImage(filter: filter)

// Modifies the pixel values in an image by applying a set of cubic polynomials.
filter = CIFilter(name: "CIColorPolynomial")!
filter.setValue(inputImage, forKey: kCIInputImageKey)
filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.4), forKey: kCIInputRedCoefficientsKey)
filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.5, w: 0.8), forKey: kCIInputGreenCoefficientsKey)
filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.5, w: 1.0), forKey: kCIInputBlueCoefficientsKey)
filter.setValue(CIVector(x: 0.0, y: 1.0, z: 1.0, w: 1.0), forKey: kCIInputAlphaCoefficientsKey)
showImage(filter: filter)

//
let imageUrl = Bundle.main.urlForImageResource("depth.jpg")!
let depthImage = CIImage(contentsOf: imageUrl, options: [.auxiliaryDepth: true])!
filter = CIFilter(name: "CIDepthToDisparity", parameters: [
    kCIInputImageKey: depthImage
])!
showImage(filter: filter)

//
let disparityImage = CIImage(contentsOf: imageUrl, options: [.auxiliaryDisparity: true])!
filter = CIFilter(name: "CIDisparityToDepth", parameters: [
    kCIInputImageKey: disparityImage
])!
showImage(filter: filter)

// Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.
filter = CIFilter(name: "CIExposureAdjust", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputEVKey: 0.8
])!
showImage(filter: filter)

// Adjusts midtone brightness.
filter = CIFilter(name: "CIGammaAdjust", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputPowerKey: 2.0
])!
showImage(filter: filter)

// Changes the overall hue, or tint, of the source pixels.
//
// This filter essentially rotates the color cube around the neutral axis.
filter = CIFilter(name: "CIHueAdjust", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputAngleKey: Float.pi * 2 / 3
])!
showImage(filter: filter)

// Maps color intensity from a linear gamma curve to the sRGB color space.
filter = CIFilter(name: "CILinearToSRGBToneCurve", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Maps color intensity from the sRGB color space to a linear gamma curve.
filter = CIFilter(name: "CISRGBToneCurveToLinear", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Adapts the reference white point for an image.
filter = CIFilter(name: "CITemperatureAndTint", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputNeutralKey: CIVector(x: 6500, y: 0),
    kCIInputTargetNeutralKey: CIVector(x: 6500, y: 0)
])!
showImage(filter: filter)

// Adjusts tone response of the R, G, and B channels of an image.
//
// The input points are five x,y values that are interpolated using a spline curve.
// The curve is applied in a perceptual (gamma 2) version of the working space.
filter = CIFilter(name: "CIToneCurve", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputPoint0Key: CIVector(x: 0.00, y: 0.00),
    kCIInputPoint1Key: CIVector(x: 0.25, y: 0.25),
    kCIInputPoint2Key: CIVector(x: 0.50, y: 0.50),
    kCIInputPoint3Key: CIVector(x: 0.75, y: 0.75),
    kCIInputPoint4Key: CIVector(x: 1.00, y: 1.00)
])!
showImage(filter: filter)

// Adjusts the saturation of an image while keeping pleasing skin tones.
filter = CIFilter(name: "CIVibrance", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputAmountKey: 1.0
])!
showImage(filter: filter)

// Adjusts the reference white point for an image and maps all colors in the source using the new reference.
filter = CIFilter(name: "CIWhitePointAdjust", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
])!
showImage(filter: filter)

//
filter = CIFilter(name: "CIFaceBalance", parameters: [
    kCIInputImageKey: inputImage,
    "inputOrigQ": 0.0176465, // -0.5 - 0.5
    "inputOrigI": 0.103905, // -0.5 - 0.5
    "inputStrength": 0.5, // 0 - 2
    "inputWarmth": 0.5 // 0 - 1
])!
showImage(filter: filter)

// auto enhancing
var outputImage = inputImage
let adjustments = outputImage.autoAdjustmentFilters()
for filter in adjustments {
    filter.setValue(outputImage, forKey: kCIInputImageKey)
    outputImage = filter.outputImage!
}
showImage(image: outputImage, extent: outputImage.extent)

//: [Next](@next)
