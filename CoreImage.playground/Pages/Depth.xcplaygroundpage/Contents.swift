//
//  Depth.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage
import AVFoundation

// https://www.raywenderlich.com/314-image-depth-maps-tutorial-for-ios-getting-started

let imageUrl = Bundle.main.urlForImageResource("depth.jpg")!
let mainImage = CIImage(contentsOf: imageUrl, options: [:])!

// MARK: - ImageIO

var depthData = depthDataForImage("depth.jpg") // disparity
// Check native depth data type
if depthData.depthDataType != kCVPixelFormatType_DisparityFloat32 {
    depthData = depthData.converting(toDepthDataType: kCVPixelFormatType_DisparityFloat32)
}
// Get the underlying buffer
let depthDataMap = depthData.depthDataMap
depthDataMap.normalize()

var disparityImage = CIImage(cvPixelBuffer: depthDataMap)
showImage(image: disparityImage)

// Convert to depth using dedicated CIFilter
var depthImage = disparityImage.applyingFilter("CIDisparityToDepth")
showImage(image: depthImage)

// Convert to disparity using dedicated CIFilter
disparityImage = depthImage.applyingFilter("CIDepthToDisparity")
showImage(image: disparityImage)

let blurImage = mainImage.applyingFilter("CIDepthBlurEffect", parameters: [
    kCIInputImageKey: mainImage,
    kCIInputDisparityImageKey: disparityImage
])
showImage(image: blurImage)

// MARK: - CoreImage

depthImage = CIImage(contentsOf: imageUrl, options: [.auxiliaryDepth: true])!
showImage(image: depthImage)

disparityImage = CIImage(contentsOf: imageUrl, options: [.auxiliaryDisparity: true])!
showImage(image: disparityImage)

let upsampleImage = mainImage.applyingFilter("CIEdgePreserveUpsampleFilter", parameters: [
    kCIInputImageKey: mainImage,
    "inputLumaSigma": 0.15,
    "inputSpatialSigma": 3.0,
    "inputSmallImage": disparityImage
])
showImage(image: upsampleImage)

let filter = CIFilter(name: "CIDepthBlurEffect", parameters: [
    kCIInputImageKey: mainImage,
    kCIInputDisparityImageKey: upsampleImage
])!
showImage(filter: filter)

//: [Next](@next)
