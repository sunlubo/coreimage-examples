//
//  DistortionEffect.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// distortion: 变形，扭曲
// Distortion effects, such as bump, twirl, hole
CIFilter.filterNames(inCategory: kCICategoryDistortionEffect).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

// Creates a bump(凸起) that originates at a specified point in the image.
var filter = CIFilter(name: "CIBumpDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 300.0,
    kCIInputScaleKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Creates a concave(凹面) or convex(凸面) distortion that originates from a line in the image.
filter = CIFilter(name: "CIBumpDistortionLinear", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 300.0,
    kCIInputAngleKey: 0.0,
    kCIInputScaleKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// TODO: CICameraCalibrationLensCorrection

// Distorts the pixels starting at the circumference(圆周) of a circle and emanating(从...处传出) outward.
filter = CIFilter(name: "CICircleSplashDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 150,
])!
showImage(filter: filter, extent: inputImage.extent)

// Wraps an image around a transparent circle.
filter = CIFilter(name: "CICircularWrap", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 48,
    kCIInputAngleKey: Float.pi
])!
showImage(filter: filter, extent: inputImage.extent)

// Applies the grayscale values of the second image to the first image.
filter = CIFilter(name: "CIDisplacementDistortion", parameters: [
    kCIInputImageKey: inputImage,
    "inputDisplacementImage": inputImage,
    kCIInputScaleKey: 50.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Recursively draws a portion of an image in imitation(模仿) of an M. C. Escher drawing.
filter = CIFilter(name: "CIDroste", parameters: [
    kCIInputImageKey: inputImage,
    "inputInsetPoint0": CIVector(x: 200, y: 200),
    "inputInsetPoint1": CIVector(x: 400, y: 400),
    "inputStrands": 1.0,
    "inputPeriodicity": 1.0,
    "inputRotation": 0.0,
    "inputZoom": 1.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Distorts an image by applying a glass-like texture.
filter = CIFilter(name: "CIGlassDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTextureKey: CIImage(named: "glass_distortion"),
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputScaleKey: 200.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Creates a lozenge(菱形)-shaped lens and distorts the portion of the image over which the lens is placed.
filter = CIFilter(name: "CIGlassLozenge", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputPoint0Key: CIVector(x: 150, y: 150),
    kCIInputPoint1Key: CIVector(x: 350, y: 150),
    kCIInputRadiusKey: 100.0,
    kCIInputRefractionKey: 1.7
])!
showImage(filter: filter, extent: inputImage.extent)

// Creates a circular area that pushes the image pixels outward, distorting those pixels closest to the circle the most.
filter = CIFilter(name: "CIHoleDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 160.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Rotates a portion of the input image specified by the center and radius parameters to give a tunneling effect.
filter = CIFilter(name: "CILightTunnel", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 100.0,
    kCIInputRotationKey: Float.pi
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CINinePartStretched", parameters: [
    kCIInputImageKey: inputImage,
    "inputBreakpoint0": CIVector(x: 50, y: 50),
    "inputBreakpoint1": CIVector(x: 150, y: 150),
    "inputGrowAmount": CIVector(x: 100, y: 100)
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CINinePartTiled", parameters: [
    kCIInputImageKey: inputImage,
    "inputBreakpoint0": CIVector(x: 50, y: 50),
    "inputBreakpoint1": CIVector(x: 150, y: 150),
    "inputGrowAmount": CIVector(x: 100, y: 100),
    "inputFlipYTiles": 1
])!
showImage(filter: filter, extent: inputImage.extent)

// Creates a rectangular area that pinches source pixels inward, distorting those pixels closest to the rectangle the most.
filter = CIFilter(name: "CIPinchDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 300.0,
    kCIInputScaleKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Distorts an image by stretching and or cropping it to fit a target size.
filter = CIFilter(name: "CIStretchCrop", parameters: [
    kCIInputImageKey: inputImage,
    "inputSize": CIVector(x: 800, y: 800),
    "inputCropAmount": 1.0,
    "inputCenterStretchAmount": 1.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Creates a torus(圆环面)-shaped lens and distorts the portion of the image over which the lens is placed.
filter = CIFilter(name: "CITorusLensDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 160.0,
    kCIInputWidthKey: 80.0,
    kCIInputRefractionKey: 1.7
])!
showImage(filter: filter, extent: inputImage.extent)

// Rotates pixels around a point to give a twirling(转动) effect.
filter = CIFilter(name: "CITwirlDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 300.0,
    kCIInputAngleKey: 3.14
])!
showImage(filter: filter, extent: inputImage.extent)

// Rotates pixels around a point to simulate a vortex(漩涡).
filter = CIFilter(name: "CIVortexDistortion", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 300.0,
    kCIInputAngleKey: 56.55
])!
showImage(filter: filter, extent: inputImage.extent)

//: [Next](@next)
