//
//  Stylize.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage
import CoreML

// Stylize, such as pixellate, crystallize
CIFilter.filterNames(inCategory: kCICategoryStylize).forEach { print($0) }

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let backgroundImage = CIImage(named: "sunset")
showImage(image: backgroundImage, extent: backgroundImage.extent)

// Uses values from a grayscale mask to interpolate between an image and the background.
let stripesImage = CIFilter(name: "CIStripesGenerator")!.outputImage!
let negativeImage = inputImage.applyingFilter("CIColorInvert")
var filter = CIFilter(name: "CIBlendWithMask", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputBackgroundImageKey: negativeImage,
    kCIInputMaskImageKey: stripesImage
])!
showImage(filter: filter, extent: inputImage.extent)

// Uses alpha values from a mask to interpolate between an image and the background.
let radialMask = CIFilter(name: "CIRadialGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadius0Key: 160,
    kCIInputRadius1Key: 320,
    kCIInputColor0Key: CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0),
    kCIInputColor1Key: CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
])!.outputImage!.cropped(to: inputImage.extent)
filter = CIFilter(name: "CIBlendWithAlphaMask", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputBackgroundImageKey: backgroundImage,
    kCIInputMaskImageKey: radialMask
])!
showImage(filter: filter)

// Uses blue values from a mask to interpolate between an image and the background.
let radialBlueMask = CIFilter(name: "CIRadialGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadius0Key: 160,
    kCIInputRadius1Key: 320,
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 0.0, blue: 0.0)
])!.outputImage!.cropped(to: inputImage.extent)
filter = CIFilter(name: "CIBlendWithBlueMask", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputBackgroundImageKey: backgroundImage,
    kCIInputMaskImageKey: radialBlueMask
])!
showImage(filter: filter)

// Uses red values from a mask to interpolate between an image and the background.
let radialRedMask = CIFilter(name: "CIRadialGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadius0Key: 160,
    kCIInputRadius1Key: 320,
    kCIInputColor0Key: CIColor(red: 1.0, green: 0.0, blue: 0.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 0.0, blue: 0.0)
])!.outputImage!.cropped(to: inputImage.extent)
filter = CIFilter(name: "CIBlendWithRedMask", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputBackgroundImageKey: backgroundImage,
    kCIInputMaskImageKey: radialRedMask
])!
showImage(filter: filter)

// Softens edges and applies a pleasant glow to an image.
filter = CIFilter(name: "CIBloom", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 8,
    kCIInputIntensityKey: 1.25
])!
showImage(filter: filter, extent: inputImage.extent)

// Simulates a comic book drawing by outlining edges and applying a color halftone effect.
filter = CIFilter(name: "CIComicEffect", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter, extent: inputImage.extent)

//
let inputModel = MLModel.loadModel(named: "FNS-Candy")
// let inputModel = MLModel.loadModel(named: "FNS-Feathers")
// let inputModel = MLModel.loadModel(named: "FNS-La-Muse")
// let inputModel = MLModel.loadModel(named: "FNS-Mosaic")
// let inputModel = MLModel.loadModel(named: "FNS-The-Scream")
// let inputModel = MLModel.loadModel(named: "FNS-Udnie")
filter = CIFilter(name: "CICoreMLModelFilter", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputModelKey: inputModel
])!
showImage(filter: filter)

// Creates polygon-shaped color blocks by aggregating source pixel-color values.
filter = CIFilter(name: "CICrystallize", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 20.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Simulates a depth of field effect.
filter = CIFilter(name: "CIDepthOfField", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputPoint0Key: CIVector(x: 320, y: 400),
    kCIInputPoint1Key: CIVector(x: 320, y: 320),
    kCIInputSaturationKey: 1.5,
    "inputUnsharpMaskRadius": 2.5,
    "inputUnsharpMaskIntensity": 0.5,
    kCIInputRadiusKey: 6
])!
showImage(filter: filter)

// Finds all edges in an image and displays them in color.
filter = CIFilter(name: "CIEdges", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputIntensityKey: 1.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a stylized black-and-white rendition of an image that looks similar to a woodblock cutout.
filter = CIFilter(name: "CIEdgeWork", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 3.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Dulls the highlights of an image.
filter = CIFilter(name: "CIGloom", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputRadiusKey: 10.0,
    kCIInputIntensityKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Produces a continuous three-dimensional, loft-shaped height field from a grayscale mask.
let mtaImage = CIImage(named: "coreImageForSwift").applyingFilter("CIColorInvert").applyingFilter("CIMaskToAlpha")
filter = CIFilter(name: "CIHeightFieldFromMask", parameters: [
    kCIInputImageKey: mtaImage,
    kCIInputRadiusKey: 10.0
])!
showImage(filter: filter)

// Produces a shaded image from a height field.
let heightFieldImage = filter.outputImage!
let shadingImage = CIImage(named: "sphere")
filter = CIFilter(name: "CIShadedMaterial", parameters: [
    kCIInputImageKey: heightFieldImage,
    kCIInputShadingImageKey: shadingImage,
    kCIInputScaleKey: 10.0
])!
showImage(filter: filter)

// Maps an image to colored hexagons whose color is defined by the replaced pixels.
filter = CIFilter(name: "CIHexagonalPixellate", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputScaleKey: 8.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Adjust the tonal mapping of an image while preserving spatial detail.
filter = CIFilter(name: "CIHighlightShadowAdjust", parameters: [
    kCIInputImageKey: inputImage,
    "inputHighlightAmount": 1.0,
    "inputShadowAmount": 1.0
])!
showImage(filter: filter)

// Creates a sketch that outlines the edges of an image in black.
filter = CIFilter(name: "CILineOverlay", parameters: [
    kCIInputImageKey: inputImage,
    "inputNRNoiseLevel": 0.07,
    "inputNRSharpness": 0.71,
    "inputEdgeIntensity": 1.0,
    "inputThreshold": 0.5,
    kCIInputContrastKey: 50.0
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CIMix", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputBackgroundImageKey: backgroundImage,
    kCIInputAmountKey: 0.5
])!
showImage(filter: filter)

// Makes an image blocky by mapping the image to colored squares whose color is defined by the replaced pixels.
filter = CIFilter(name: "CIPixellate", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputScaleKey: 10.0
])!
showImage(filter: filter, extent: inputImage.extent)

// Renders the source image in a pointillistic style.
filter = CIFilter(name: "CIPointillize", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputRadiusKey: 10.0
])!
showImage(filter: filter, extent: inputImage.extent)

//
filter = CIFilter(name: "CISaliencyMapFilter", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

//
filter = CIFilter(name: "CISampleNearest", parameters: [
    kCIInputImageKey: inputImage
])!
showImage(filter: filter)

// Replaces one or more color ranges with spot colors.
filter = CIFilter(name: "CISpotColor", parameters: [
    kCIInputImageKey: inputImage,
    "inputCenterColor1": CIColor(red: 0.0784, green: 0.0627, blue: 0.0706, alpha: 1.0),
    "inputReplacementColor1": CIColor(red: 0.4392, green: 0.1922, blue: 0.1961, alpha: 1.0),
    "inputCloseness1": 0.22,
    "inputContrast1": 0.98,
    "inputCenterColor2": CIColor(red: 0.5255, green: 0.3059, blue: 0.3451, alpha: 1.0),
    "inputReplacementColor2": CIColor(red: 0.9137, green: 0.5608, blue: 0.5059, alpha: 1.0),
    "inputCloseness2": 0.15,
    "inputContrast2": 0.98,
    "inputCenterColor3": CIColor(red: 0.9216, green: 0.4549, blue: 0.3333, alpha: 1.0),
    "inputReplacementColor3": CIColor(red: 0.9098, green: 0.7529, blue: 0.6078, alpha: 1.0),
    "inputCloseness3": 0.5,
    "inputContrast3": 0.99
])!
showImage(filter: filter)

// Applies a directional spotlight effect to an image.
filter = CIFilter(name: "CISpotLight", parameters: [
    kCIInputImageKey: inputImage,
    "inputLightPosition": CIVector(x: 600, y: 600, z: 150),
    "inputLightPointsAt": CIVector(x: 320, y: 220, z: 0),
    kCIInputBrightnessKey: 3.0,
    "inputConcentration": 0.5,
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0)
])!
showImage(filter: filter)

//: [Next](@next)
