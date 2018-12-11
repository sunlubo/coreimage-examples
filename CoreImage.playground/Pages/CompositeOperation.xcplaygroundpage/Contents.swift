//
//  CompositeOperation.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Compositing, such as source over, minimum, source atop, color dodge blend mode
// https://keithp.com/~keithp/porterduff/p253-porter.pdf
// https://www.adobe.com/devnet/pdf/pdf_reference.html
CIFilter.filterNames(inCategory: kCICategoryCompositeOperation).forEach { print($0) }

let foregroundImage = CIImage(named: "girl")
showImage(image: foregroundImage)

let backgroundImage = CIImage(named: "sunset")
showImage(image: backgroundImage)

// Adds color components to achieve a brightening effect.
var filter = CIFilter(name: "CIAdditionCompositing", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Uses the luminance values of the background with the hue and saturation values of the source image.
filter = CIFilter(name: "CIColorBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Darkens the background image samples to reflect the source image samples.
filter = CIFilter(name: "CIColorBurnBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Brightens the background image samples to reflect the source image samples.
filter = CIFilter(name: "CIColorDodgeBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Creates composite image samples by choosing the darker samples (from either the source image or the background).
filter = CIFilter(name: "CIDarkenBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Subtracts either the source image sample color from the background image sample color, or the reverse, depending on which sample has the greater brightness value.
filter = CIFilter(name: "CIDifferenceBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Divides the background image sample color from the source image sample color.
filter = CIFilter(name: "CIDivideBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Produces an effect similar to that produced by the CIDifferenceBlendMode filter but with lower contrast.
filter = CIFilter(name: "CIExclusionBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Either multiplies or screens colors, depending on the source image sample color.
filter = CIFilter(name: "CIHardLightBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Uses the luminance and saturation values of the background image with the hue of the input image.
filter = CIFilter(name: "CIHueBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Creates composite image samples by choosing the lighter samples (either from the source image or the background).
filter = CIFilter(name: "CILightenBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Darkens the background image samples to reflect the source image samples while also increasing contrast.
filter = CIFilter(name: "CILinearBurnBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Brightens the background image samples to reflect the source image samples while also increasing contrast.
filter = CIFilter(name: "CILinearDodgeBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Uses the hue and saturation of the background image with the luminance of the input image.
filter = CIFilter(name: "CILuminosityBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Computes the maximum value, by color component, of two input images and creates an output image using the maximum values.
filter = CIFilter(name: "CIMaximumCompositing", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Computes the minimum value, by color component, of two input images and creates an output image using the minimum values.
filter = CIFilter(name: "CIMinimumCompositing", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Multiplies the input image samples with the background image samples.
filter = CIFilter(name: "CIMultiplyBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Multiplies the color component of two input images and creates an output image using the multiplied values.
filter = CIFilter(name: "CIMultiplyCompositing", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Either multiplies or screens the input image samples with the background image samples, depending on the background color.
filter = CIFilter(name: "CIOverlayBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Conditionally replaces background image samples with source image samples depending on the brightness of the source image samples.
filter = CIFilter(name: "CIPinLightBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Uses the luminance and hue values of the background image with the saturation of the input image.
filter = CIFilter(name: "CISaturationBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Multiplies the inverse of the input image samples with the inverse of the background image samples.
filter = CIFilter(name: "CIScreenBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Either darkens or lightens colors, depending on the input image sample color.
filter = CIFilter(name: "CISoftLightBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Places the input image over the background image, then uses the luminance of the background image to determine what to show.
filter = CIFilter(name: "CISourceAtopCompositing", parameters: [
    kCIInputImageKey: CIImage(named: "qrcode"),
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Uses the background image to define what to leave in the input image, effectively cropping the input image.
filter = CIFilter(name: "CISourceInCompositing", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: CIImage(named: "qrcode")
])!
showImage(filter: filter)

// Uses the background image to define what to take out of the input image.
filter = CIFilter(name: "CISourceOutCompositing", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: CIImage(named: "qrcode")
])!
showImage(filter: filter)

// Places the input image over the input background image.
filter = CIFilter(name: "CISourceOverCompositing", parameters: [
    kCIInputImageKey: CIImage(named: "qrcode"),
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

// Subtracts the background image sample color from the source image sample color.
filter = CIFilter(name: "CISubtractBlendMode", parameters: [
    kCIInputImageKey: foregroundImage,
    kCIInputBackgroundImageKey: backgroundImage
])!
showImage(filter: filter)

//: [Next](@next)
