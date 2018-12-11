//
//  Reduction.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

CIFilter.filterNames(inCategory: kCICategoryReduction).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let roi = CIVector(x: 220, y: 220, z: 200, w: 200)

// Returns a single-pixel image that contains the average color for the region of interest.
var filter = CIFilter(name: "CIAreaAverage", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

// Returns a single-pixel image that contains the maximum color components for the region of interest.
filter = CIFilter(name: "CIAreaMaximum", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

// Returns a single-pixel image that contains the minimum color components for the region of interest.
filter = CIFilter(name: "CIAreaMinimum", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

// Returns a single-pixel image that contains the color vector with the maximum alpha value for the region of interest.
filter = CIFilter(name: "CIAreaMaximumAlpha", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

// Returns a single-pixel image that contains the color vector with the minimum alpha value for the region of interest.
filter = CIFilter(name: "CIAreaMinimumAlpha", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

//
filter = CIFilter(name: "CIAreaMinMax", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

//
filter = CIFilter(name: "CIAreaMinMaxRed", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: roi
])!
showColor(filter: filter)

// Returns a 1D image (inputCount wide by one pixel high) that contains the component-wise histogram computed for the specified rectangular area.
filter = CIFilter(name: "CIAreaHistogram", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: CIVector(cgRect: inputImage.extent),
    kCIInputCountKey: 256,
    kCIInputScaleKey: 10
])!
let histogram = filter.outputImage!

// Generates a histogram image from the output of the CIAreaHistogram filter.
filter = CIFilter(name: "CIHistogramDisplayFilter", parameters: [
    kCIInputImageKey: histogram,
    kCIInputHeightKey: 200,
    kCIInputLowLimitKey: 0.0,
    kCIInputHighLimitKey: 1.0
])!
showImage(filter: filter)

// Returns a 1-pixel high image that contains the average color for each scan column.
filter = CIFilter(name: "CIColumnAverage", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: CIVector(cgRect: inputImage.extent)
])!
showHistogram(filter: filter)

// Returns a 1-pixel high image that contains the average color for each scan row.
filter = CIFilter(name: "CIRowAverage", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: CIVector(cgRect: inputImage.extent)
])!
showHistogram(filter: filter)

//: [Next](@next)
