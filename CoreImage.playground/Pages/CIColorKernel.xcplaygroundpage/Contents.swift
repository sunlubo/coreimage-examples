//
//  CIColorKernel.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let thresholdFilter = ThresholdFilter()
thresholdFilter.inputImage = inputImage
thresholdFilter.inputThreshold = 0.5
showImage(filter: thresholdFilter)

let swapRGFilter = SwapRedAndGreenFilter()
swapRGFilter.inputImage = inputImage
swapRGFilter.inputAmount = 0.5
showImage(filter: swapRGFilter)

let vignetteFilter = VignetteFilter()
vignetteFilter.inputImage = inputImage
showImage(filter: vignetteFilter)

let lumaFilter = LuminanceFilter()
lumaFilter.inputImage = inputImage
showImage(filter: lumaFilter)

let vibranceFilter = VibranceFilter()
vibranceFilter.inputImage = inputImage
vibranceFilter.inputVibrance = 1.0
showImage(filter: vibranceFilter)

//: [Next](@next)
