//
//  GeometryAdjustment.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import QuartzCore
import CoreImage

// Geometry adjustment, such as affine transform, crop, perspective transform
CIFilter.filterNames(inCategory: kCICategoryGeometryAdjustment).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

// Applies an affine transform to an image.
//
// You can scale, translate, or rotate the input image. You can also apply a combination of these operations.
var filter = CIFilter(name: "CIAffineTransform", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTransformKey: CGAffineTransform(rotationAngle: .pi / 6)
])!
showImage(filter: filter, extent: inputImage.extent)

// 双三次插值
filter = CIFilter(name: "CIBicubicScaleTransform", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputScaleKey: 1.5,
    kCIInputAspectRatioKey: 1.0,
    "inputB": 0.0,
    "inputC": 0.75
])!
showImage(filter: filter)

// Applies a crop to an image.
// ⚠️ 坐标系
//
// The size and shape of the cropped image depend on the rectangle you specify.
filter = CIFilter(name: "CICrop", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRectangleKey: CIVector(x: 0, y: 0, z: 320, w: 320)
])!
showImage(filter: filter)

//
let refImage = colorImage(color: CIColor(red: 1.0, green: 1.0, blue: 1.0), size: CGSize(width: 1280, height: 1280))
filter = CIFilter(name: "CIEdgePreserveUpsampleFilter", parameters: [
    kCIInputImageKey: refImage,
    "inputSmallImage": inputImage,
    "inputLumaSigma": 0.15,
    "inputSpatialSigma": 3.0
])!
showImage(filter: filter)

// Produces a high-quality, scaled version of a source image.
filter = CIFilter(name: "CILanczosScaleTransform", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputScaleKey: 0.5,
    kCIInputAspectRatioKey: 1.0
])!
showImage(filter: filter)

// Applies a perspective correction, transforming an arbitrary quadrilateral region in the source image to a rectangular output image.
//
// The extent of the rectangular output image varies based on the size and placement of the specified quadrilateral region in the input image.
let stickyNoteImage = CIImage(named: "stickyNote")
let detector = CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
let region = detector.features(in: stickyNoteImage)[0] as! CIRectangleFeature
filter = CIFilter(name: "CIPerspectiveCorrection", parameters: [
    kCIInputImageKey: stickyNoteImage,
    kCIInputTopLeftKey: CIVector(cgPoint: region.topLeft),
    kCIInputTopRightKey: CIVector(cgPoint: region.topRight),
    kCIInputBottomLeftKey: CIVector(cgPoint: region.bottomLeft),
    kCIInputBottomRightKey: CIVector(cgPoint: region.bottomRight)
])!
showImage(filter: filter)

// Alters the geometry of an image to simulate the observer changing viewing position.
//
// You can use the perspective filter to skew an image.
filter = CIFilter(name: "CIPerspectiveTransform", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTopLeftKey: CIVector(x: 60, y: 540),
    kCIInputTopRightKey: CIVector(x: 580, y: 600),
    kCIInputBottomLeftKey: CIVector(x: 60, y: 100),
    kCIInputBottomRightKey: CIVector(x: 580, y: 40)
])!
showImage(filter: filter, extent: inputImage.extent)

// Alters the geometry of a portion of an image to simulate the observer changing viewing position.
filter = CIFilter(name: "CIPerspectiveTransformWithExtent", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: CIVector(x: 160, y: 160, z: 320, w: 320),
    kCIInputTopLeftKey: CIVector(x: 40, y: 240),
    kCIInputTopRightKey: CIVector(x: 280, y: 280),
    kCIInputBottomLeftKey: CIVector(x: 40, y: 80),
    kCIInputBottomRightKey: CIVector(x: 280, y: 40)
])!
showImage(filter: filter)

// Rotates the source image by the specified angle in radians.
//
// The image is scaled and cropped so that the rotated image fits the extent of the input image.
filter = CIFilter(name: "CIStraightenFilter", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputAngleKey: CGFloat.pi / 3
])!
showImage(filter: filter)

//: [Next](@next)
