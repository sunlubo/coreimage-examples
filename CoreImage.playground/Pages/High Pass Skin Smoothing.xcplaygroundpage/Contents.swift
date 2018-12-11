//
//  High Pass Skin Smoothing.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

// https://github.com/YuAo/YUCIHighPassSkinSmoothing

let inputImage = CIImage(named: "sample")
showImage(image: inputImage)

let highPass = HighPassFilter()
highPass.inputImage = inputImage
highPass.inputRadius = 20
showImage(filter: highPass)

let toneCurve = RGBToneCurveFilter()
toneCurve.inputImage = inputImage
toneCurve.inputRGBCompositeControlPoints = [CIVector(x: 0.0, y: 0.0), CIVector(x: 0.5, y: 0.7), CIVector(x: 1.0, y: 1.0)]
showImage(filter: toneCurve)

let blendFilter = GreenBlueChannelOverlayBlendFilter()
blendFilter.inputImage = inputImage
showImage(filter: blendFilter)

let skinSmoothingFilter = HighPassSkinSmoothingFilter()
skinSmoothingFilter.inputImage = inputImage
showImage(filter: skinSmoothingFilter)

//: [Next](@next)
