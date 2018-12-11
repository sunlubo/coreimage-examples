//
//  ColorEffect.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Color effect, such as hue adjust, posterize
CIFilter.filterNames(inCategory: kCICategoryColorEffect).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage)

// Modifies the pixel values in an image by applying a set of polynomial cross-products.
var filter = CIFilter(name: "CIColorCrossPolynomial", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRedCoefficientsKey: CIVector(string: "[1 0 0 0 0 0 0 0 0 0]"),
    kCIInputGreenCoefficientsKey: CIVector(string: "[0 1 0 0 0 0 0 0 0 0]"),
    kCIInputBlueCoefficientsKey: CIVector(string: "[0 0 1 0 0 0 0 0 0 0]"),
])!
showImage(filter: filter)

let lut = generateLoockupTexture()

// Uses a three-dimensional color table to transform the source image pixels.
// let cubeData = colorCube(size: 64, fromHue: 0.5, toHue: 0.8)
// let cubeData = colorCubeFromImage(CGImage.image(named: "neutral-lut"))
let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M01"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M02"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M03"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M05"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M06"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M07"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M08"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M09"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M011"))
// let cubeData = colorCubeFromImage(CGImage.image(named: "LUT_M012"))
filter = CIFilter(name: "CIColorCube", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCubeDimensionKey: 64,
    kCIInputCubeDataKey: cubeData
])!
showImage(filter: filter)

// Uses a three-dimensional color table to transform the source image pixels and maps the result to a specified color space.
let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) ?? CGColorSpaceCreateDeviceRGB()
filter = CIFilter(name: "CIColorCubeWithColorSpace", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCubeDimensionKey: 64,
    kCIInputCubeDataKey: cubeData,
    kCIInputColorSpaceKey: colorSpace
])!
showImage(filter: filter)

// TODO: CIColorCubesMixedWithMask

// 颜色曲线
var inputCurves = InputCurves(shadows: CurvesRGB(r: 0, g: 0, b: 0), midtones: CurvesRGB(r: 0.5, g: 1.0, b: 0.5), highlights: CurvesRGB(r: 1, g: 1, b: 1))
let curvesData = Data(bytes: &inputCurves, count: MemoryLayout<InputCurves>.size)
filter = CIFilter(name: "CIColorCurves", parameters: [
    kCIInputImageKey: inputImage,
    "inputCurvesDomain": CIVector(x: 0, y: 1),
    "inputCurvesData": curvesData,
    kCIInputColorSpaceKey: colorSpace
])!
showImage(filter: filter)

// Inverts the colors in an image.
filter = CIFilter(name: "CIColorInvert", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Performs a nonlinear transformation of source color values using mapping values provided in a table.
// https://en.wikipedia.org/wiki/List_of_8-bit_computer_hardware_graphics
let blueYellowWhiteColors = [
    RGB(r: 0, g: 0, b: 255),
    RGB(r: 255, g: 255, b: 0),
    RGB(r: 255, g: 255, b: 255)
]
filter = CIFilter(name: "CIColorMap", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputGradientImageKey: colorMapGradientFromColors(vic20Colors)
])!
showImage(filter: filter)

// Remaps colors so they fall within shades of a single color.
filter = CIFilter(name: "CIColorMonochrome", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0),
    kCIInputIntensityKey: 1.0
])!
showImage(filter: filter)

// Remaps red, green, and blue color components to the number of brightness values you specify for each color component.
//
// This filter flattens colors to achieve a look similar to that of a silk-screened poster.
filter = CIFilter(name: "CIColorPosterize", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputLevelsKey: 8.0
])!
showImage(filter: filter)

//
filter = CIFilter(name: "CIDither", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputIntensityKey: 0.5
])!
showImage(filter: filter)

// Maps luminance to a color ramp of two colors.
filter = CIFilter(name: "CIFalseColor", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputColor0Key: CIColor(red: 1.0, green: 0.0, blue: 0.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0),
])!
showImage(filter: filter)

// TODO: CILabDeltaE

// Converts a grayscale image to a white image that is masked by alpha.
//
// The white values from the source image produce the inside of the mask; the black values become completely transparent.
let invertImage = CIImage(named: "coreImageForSwift").applyingFilter("CIColorInvert")
filter = CIFilter(name: "CIMaskToAlpha", parameters: [
    kCIInputImageKey: invertImage
])!
showImage(filter: filter)

// Returns a grayscale image from max(r,g,b).
filter = CIFilter(name: "CIMaximumComponent", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Returns a grayscale image from min(r,g,b).
filter = CIFilter(name: "CIMinimumComponent", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate vintage photography film with exaggerated color.
filter = CIFilter(name: "CIPhotoEffectChrome", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate vintage photography film with diminished color.
filter = CIFilter(name: "CIPhotoEffectFade", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate vintage photography film with distorted colors.
filter = CIFilter(name: "CIPhotoEffectInstant", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate black-and-white photography film with low contrast.
filter = CIFilter(name: "CIPhotoEffectMono", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate black-and-white photography film with exaggerated contrast.
filter = CIFilter(name: "CIPhotoEffectNoir", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate vintage photography film with emphasized cool colors.
filter = CIFilter(name: "CIPhotoEffectProcess", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate black-and-white photography film without significantly altering contrast.
filter = CIFilter(name: "CIPhotoEffectTonal", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Applies a preconfigured set of effects that imitate vintage photography film with emphasized warm colors.
filter = CIFilter(name: "CIPhotoEffectTransfer", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Maps the colors of an image to various shades of brown.
filter = CIFilter(name: "CISepiaTone", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputIntensityKey: 0.5
])!
showImage(filter: filter)

//
filter = CIFilter(name: "CIThermal", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Reduces the brightness of an image at the periphery(外围, 边缘).
filter = CIFilter(name: "CIVignette", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 2.0,
    kCIInputIntensityKey: 1.0
])!
showImage(filter: filter)

// Modifies the brightness of an image around the periphery of a specified region.
filter = CIFilter(name: "CIVignetteEffect", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 150.0,
    kCIInputIntensityKey: 0.6
])!
showImage(filter: filter)

//
filter = CIFilter(name: "CIXRay", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

//: [Next](@next)
