//
//  Generator.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Image generator, such as stripes, constant color, checkerboard
CIFilter.filterNames(inCategory: kCICategoryGenerator).forEach { print($0) }

let message = "Hello, core image!".data(using: .utf8)!
let extent = CGRect(x: 0, y: 0, width: 200, height: 200)

let attributedString = NSAttributedString(string: "Hello, Core Image!", attributes: [
    .foregroundColor: NSColor.white,
    .font: NSFont.systemFont(ofSize: 24)
])
var filter = CIFilter(name: "CIAttributedTextImageGenerator", parameters: [
    kCIInputTextKey: attributedString,
    kCIInputScaleFactorKey: 2
])!
showImage(filter: filter)

// TODO: CIAztecCodeGenerator

// TODO: CIBarcodeGenerator

// Generates a checkerboard pattern.
filter = CIFilter(name: "CICheckerboardGenerator", parameters: [
    kCIInputCenterKey: CIVector(x: 100, y: 100),
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0),
    kCIInputWidthKey: 40.0,
    kCIInputSharpnessKey: 1.0
])!
showImage(filter: filter, extent: extent)

// Generates a Code 128 one-dimensional barcode from input data.
filter = CIFilter(name: "CICode128BarcodeGenerator", parameters: [
    kCIInputMessageKey: message,
    "inputQuietSpace": 7.0
])!
showImage(filter: filter)

// Generates a solid color.
filter = CIFilter(name: "CIConstantColorGenerator", parameters: [
    kCIInputColorKey: CIColor(red: 0.0, green: 0.0, blue: 1.0)
])!
showImage(filter: filter, extent: extent)

// Simulates a lens flare.
filter = CIFilter(name: "CILenticularHaloGenerator", parameters: [
    kCIInputCenterKey: CIVector(x: 100, y: 100),
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0),
    "inputHaloRadius": 20.0,
    "inputHaloWidth": 60.0,
    "inputHaloOverlap": 0.77,
    "inputStriationStrength": 0.5,
    "inputStriationContrast": 1.0,
    kCIInputTimeKey: 0.0
])!
showImage(filter: filter)

//
let mesh = [CIVector(x: 0, y: 0, z: 200, w: 200), CIVector(x: 0, y: 200, z: 200, w: 0)]
filter = CIFilter(name: "CIMeshGenerator", parameters: [
    kCIInputMeshKey: mesh,
    kCIInputColorKey: CIColor.red,
    kCIInputWidthKey: 5
])!
showImage(filter: filter)

// TODO: CIPDF417BarcodeGenerator

// Generates a Quick Response code (two-dimensional barcode) from input data.
filter = CIFilter(name: "CIQRCodeGenerator", parameters: [
    kCIInputMessageKey: message,
    "inputCorrectionLevel": "M",
])!
showImage(filter: filter)

// Generates an image of infinite extent whose pixel values are made up of four independent,
// uniformly-distributed random numbers in the 0 to 1 range.
filter = CIFilter(name: "CIRandomGenerator")!
showImage(filter: filter, extent: extent)

// Generates a starburst pattern that is similar to a supernova; can be used to simulate a lens flare.
filter = CIFilter(name: "CIStarShineGenerator", parameters: [
    kCIInputCenterKey: CIVector(x: 150, y: 150),
    kCIInputColorKey: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputRadiusKey: 50.0,
    "inputCrossScale": 15.0,
    "inputCrossAngle": 0.6,
    "inputCrossOpacity": -2.0,
    "inputCrossWidth": 2.5,
    "inputEpsilon": -2.0
])!
showImage(filter: filter, extent: extent)

// Generates a stripe pattern.
filter = CIFilter(name: "CIStripesGenerator", parameters: [
    kCIInputCenterKey: CIVector(x: 100, y: 100),
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0),
    kCIInputWidthKey: 40.0,
    kCIInputSharpnessKey: 1.0
])!
showImage(filter: filter, extent: extent)

// Generates a sun effect.
filter = CIFilter(name: "CISunbeamsGenerator", parameters: [
    kCIInputCenterKey: CIVector(x: 150, y: 150),
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0),
    "inputSunRadius": 40.0,
    "inputMaxStriationRadius": 2.58,
    "inputStriationStrength": 0.5,
    "inputStriationContrast": 1.38,
    kCIInputTimeKey: 0.0
])!
showImage(filter: filter)

//
filter = CIFilter(name: "CITextImageGenerator", parameters: [
    kCIInputTextKey: "Hello, Core Image!",
    "inputFontName": "HelveticaNeue",
    "inputFontSize": 24,
    kCIInputScaleFactorKey: 2
])!
showImage(filter: filter)

//: [Next](@next)
