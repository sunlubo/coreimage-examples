//
//  TileEffect.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Tile effect, such as parallelogram, triangle
CIFilter.filterNames(inCategory: kCICategoryTileEffect).forEach { print($0) }

let inputImage = CIImage(named: "sunset")
showImage(image: inputImage, extent: inputImage.extent)

// Performs an affine transform on a source image and then clamps the pixels at the edge of the transformed image, extending them outwards.
var filter = CIFilter(name: "CIAffineClamp", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTransformKey: CGAffineTransform(rotationAngle: .pi / 6)
])!
showImage(filter: filter, extent: inputImage.extent)

// Applies an affine transform to an image and then tiles the transformed image.
filter = CIFilter(name: "CIAffineTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTransformKey: CGAffineTransform(scaleX: 0.2, y: 0.2)
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CIClamp", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 200, w: 200)
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by applying an 8-way reflected symmetry.
filter = CIFilter(name: "CIEightfoldReflectedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by applying a 4-way reflected symmetry.
filter = CIFilter(name: "CIFourfoldReflectedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputAcuteAngleKey: 1.57,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by rotating the source image at increments of 90 degrees.
filter = CIFilter(name: "CIFourfoldRotatedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by applying 4 translation operations.
filter = CIFilter(name: "CIFourfoldTranslatedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputAcuteAngleKey: 1.57,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by translating and smearing the image.
filter = CIFilter(name: "CIGlideReflectedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a kaleidoscopic image from a source image by applying 12-way symmetry.
filter = CIFilter(name: "CIKaleidoscope", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputCountKey: 6.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Segments an image, applying any specified scaling and rotation, and then assembles the image again to give an op art appearance.
filter = CIFilter(name: "CIOpTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputScaleKey: 2.8,
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 65.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Warps an image by reflecting it in a parallelogram, and then tiles the result.
filter = CIFilter(name: "CIParallelogramTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputAcuteAngleKey: 1.57,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Applies a perspective transform to an image and then tiles the result.
filter = CIFilter(name: "CIPerspectiveTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTopLeftKey: CIVector(x: 220, y: 220),
    kCIInputTopRightKey: CIVector(x: 420, y: 220),
    kCIInputBottomRightKey: CIVector(x: 420, y: 420),
    kCIInputBottomLeftKey: CIVector(x: 220, y: 420)
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by applying a 6-way reflected symmetry.
filter = CIFilter(name: "CISixfoldReflectedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by rotating the source image at increments of 60 degrees.
filter = CIFilter(name: "CISixfoldRotatedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Maps a triangular portion of an input image to create a kaleidoscope effect.
filter = CIFilter(name: "CITriangleKaleidoscope", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputPointKey: CIVector(x: 320, y: 320),
    kCIInputSizeKey: 700.0,
    kCIInputRotationKey: -0.36,
    kCIInputDecayKey: 0.85
])!
showImage(filter: filter, extent: inputImage.extent)

// Maps a triangular portion of image to a triangular area and then tiles the result.
filter = CIFilter(name: "CITriangleTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a tiled image from a source image by rotating the source image at increments of 30 degrees.
filter = CIFilter(name: "CITwelvefoldReflectedTile", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 100.0
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
