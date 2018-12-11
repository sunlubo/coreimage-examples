//
//  Applying a Chroma Key Effect.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Replace a color in one image with the background from another.
//
// The chroma key effect, also known as bluescreening or greenscreening, sets a color or range of colors in an image
// to transparent (alpha = 0) so that you can substitute a different background image.
//
// https://developer.apple.com/documentation/coreimage/applying_a_chroma_key_effect

let foregroundImage = CIImage(named: "airplane")
let backgroundImage = CIImage(named: "sunset")

let chromaFilter = chromaKeyFilter(fromHue: 0.3, toHue: 0.4)!
chromaFilter.setValue(foregroundImage, forKey: kCIInputImageKey)
let sourceImageWithoutBackground = chromaFilter.outputImage

let compositor = CIFilter(name: "CISourceOverCompositing")!
compositor.setValue(sourceImageWithoutBackground, forKey: kCIInputImageKey)
compositor.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
showImage(filter: compositor)

//: [Next](@next)
