//: [Previous](@previous)

import Foundation
import CoreImage

// cd /Users/sun/Development/GitHub/iOS/iOSMedia/CoreImage.playground/Pages/MetalKernel.xcplaygroundpage/Resources
// xcrun metal -fcikernel Filters.metal -c -o Filters.air
// xcrun metallib -cikernel Filters.air -o Filters.metallib

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let minFilter = MinimumComponentFilter()
minFilter.inputImage = inputImage
showImage(filter: minFilter)

let maxFilter = MaximumComponentFilter()
maxFilter.inputImage = inputImage
showImage(filter: maxFilter)

let rgbFilter = RGBFilter()
rgbFilter.inputImage = inputImage
rgbFilter.inputType = .blue
showImage(filter: rgbFilter)

let boxBlurFilter = BoxBlurFilter()
boxBlurFilter.inputImage = inputImage
boxBlurFilter.inputRadius = 10
showImage(filter: boxBlurFilter)

//: [Next](@next)
