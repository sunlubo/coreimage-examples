//
//  Basic.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage
import AVFoundation

// https://developer.apple.com/wwdc13/509
// https://developer.apple.com/wwdc14/514
// https://developer.apple.com/wwdc14/515
// https://developer.apple.com/wwdc15/510
// https://developer.apple.com/wwdc16/505
// https://developer.apple.com/wwdc17/507
// https://developer.apple.com/wwdc17/508
// https://developer.apple.com/wwdc17/510
// https://developer.apple.com/wwdc18/503
// https://developer.apple.com/wwdc18/719
// https://developer.apple.com/documentation/coreimage
// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html#//apple_ref/doc/uid/TP30001185
// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346
// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CIKernelLangRef/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004397
// CoreImage for Swift Developers Book (1.3)

let categories = Set<String>(CIFilter.filterNames(inCategory: nil).flatMap {
    return CIFilter(name: $0)!.attributes[kCIAttributeFilterCategories] as! [String]
}).sorted()

CIFilter.filterNames(inCategory: kCICategoryStillImage).count
CIFilter.filterNames(inCategory: kCICategoryVideo).count
CIFilter.filterNames(inCategory: kCICategoryNonSquarePixels).count
CIFilter.filterNames(inCategory: kCICategoryBuiltIn).count

// An evaluation context for rendering image processing results and performing image analysis.
let options = [:] as [CIContextOption: Any]
let context = CIContext(options: options)

// A representation of an image to be processed or produced by Core Image filters.
let inputImage = CIImage(named: "girl")
// Returns a filter shape object that represents the domain of definition of the image.
inputImage.definition
// This rectangle specifies the extent of the image in working space coordinates.
inputImage.extent
// A dictionary containing metadata about the image.
inputImage.properties
// The color space of the image.
inputImage.colorSpace
// Returns all possible automatically selected and configured filters for adjusting the image.
inputImage.autoAdjustmentFilters()
// The CoreGraphics image object this image was created from, if applicable.
inputImage.cgImage
// The CoreVideo pixel buffer this image was created from, if applicable.
inputImage.pixelBuffer
// AVDepthData representation of the depth image.
inputImage.depthData
// AVPortraitEffectsMatte representation of portrait effects.
inputImage.portraitEffectsMatte

let filter = CIFilter(name: "CIPhotoEffectTransfer", parameters: [kCIInputImageKey: inputImage])!
let outputImage = filter.outputImage!

let width = Int(outputImage.extent.width), height = Int(outputImage.extent.height)
let bytesPerPixel = 4
let bytesPerRow = bytesPerPixel * width
let bitsPerComponent = 8
let bitsPerPixel = bytesPerPixel * bitsPerComponent
let bitmap = UnsafeMutablePointer<UInt8>.allocate(capacity: bytesPerRow * height)
bitmap.initialize(to: 0)
let colorSpace = CGColorSpaceCreateDeviceRGB()
// Renders to the given bitmap.
context.render(outputImage,
               toBitmap: bitmap, // Storage for the bitmap data.
               rowBytes: bytesPerRow, // The bytes per row.
               bounds: CGRect(x: 0, y: 0, width: width, height: height), // The bounds of the bitmap data.
               format: .RGBA8, // The format of the bitmap data.
               colorSpace: colorSpace) // The color space for the data. Pass nil if you want to use the output color space of the context.

// An abstraction for data-reading tasks that eliminates the need to manage a raw memory buffer.
let dataProvider = CGDataProvider(data: NSData(bytes: bitmap, length: 4 * bytesPerRow * height))!
// Component information for a bitmap image.
let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
// Creates a bitmap image from data supplied by a data provider.
let image = CGImage(width: width, // The width, in pixels, of the required image.
                    height: height, // The height, in pixels, of the required image
                    bitsPerComponent: bitsPerComponent, // The number of bits for each component in a source pixel. For example, if the source image uses the RGBA-32 format, you would specify 8 bits per component.
                    bitsPerPixel: bitsPerPixel, // The total number of bits in a source pixel. This value must be at least bitsPerComponent times the number of components per pixel.
                    bytesPerRow: bytesPerRow, // The number of bytes of memory for each horizontal row of the bitmap.
                    space: colorSpace, // The color space for the image.
                    bitmapInfo: bitmapInfo, // A constant that specifies whether the bitmap should contain an alpha channel and its relative location in a pixel, along with whether the components are floating-point or integer values.
                    provider: dataProvider, // The source of data for the bitmap.
                    decode: nil,
                    shouldInterpolate: true,
                    intent: .defaultIntent)

// CIImageAccumulator

//: [Next](@next)
