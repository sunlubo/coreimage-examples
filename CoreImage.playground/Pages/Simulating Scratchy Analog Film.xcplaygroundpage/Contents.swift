//
//  Simulating Scratchy Analog Film.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

// Degrade the quality of an image to make it look like dated, scratchy analog film.
//
// https://developer.apple.com/documentation/coreimage/simulating_scratchy_analog_film

let inputImage = CIImage(named: "girl")

// 1
let sepiaImage = CIFilter(name: "CISepiaTone", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputIntensityKey: 1.0
])!.outputImage!

// 2
let noiseImage = CIFilter(name: "CIRandomGenerator")!.outputImage!
let whiteSpecks = CIFilter(name: "CIColorMatrix", parameters: [
    kCIInputImageKey: noiseImage,
    "inputRVector": CIVector(x: 0, y: 1, z: 0, w: 0),
    "inputGVector": CIVector(x: 0, y: 1, z: 0, w: 0),
    "inputBVector": CIVector(x: 0, y: 1, z: 0, w: 0),
    "inputAVector": CIVector(x: 0, y: 0.005, z: 0, w: 0),
    "inputBiasVector": CIVector(x: 0, y: 0, z: 0, w: 0)
])!.outputImage!

// 3
let speckledImage = CIFilter(name: "CISourceOverCompositing", parameters: [
    kCIInputImageKey: whiteSpecks,
    kCIInputBackgroundImageKey: sepiaImage
])!.outputImage!

// 4
let transformedNoise = noiseImage.transformed(by: CGAffineTransform(scaleX: 1.5, y: 25))
let randomScratches = CIFilter(name: "CIColorMatrix", parameters: [
    kCIInputImageKey: transformedNoise,
    "inputRVector": CIVector(x: 4, y: 0, z: 0, w: 0),
    "inputGVector": CIVector(x: 0, y: 0, z: 0, w: 0),
    "inputBVector": CIVector(x: 0, y: 0, z: 0, w: 0),
    "inputAVector": CIVector(x: 0, y: 0, z: 0, w: 0),
    "inputBiasVector": CIVector(x: 0, y: 1, z: 1, w: 1)
])!.outputImage!
let darkScratches = CIFilter(name: "CIMinimumComponent", parameters: [
    kCIInputImageKey: randomScratches
])!.outputImage!

// 5
let oldFilmImage = CIFilter(name: "CIMultiplyCompositing", parameters: [
    kCIInputImageKey: darkScratches,
    kCIInputBackgroundImageKey: speckledImage
])!.outputImage!.cropped(to: inputImage.extent)
showImage(image: oldFilmImage)

//: [Next](@next)
