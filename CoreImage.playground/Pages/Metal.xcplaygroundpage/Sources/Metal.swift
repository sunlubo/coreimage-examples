//
//  Metal.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Cocoa
import Metal
import MetalKit

public func texture(from image: NSImage) -> MTLTexture {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        fatalError("Can't open image \(image)")
    }
    
    let textureLoader = MTKTextureLoader(device: MetalContext.shared.device)
    do {
        return try textureLoader.newTexture(cgImage: cgImage)
    } catch {
        fatalError("Can't load texture")
    }
}

public func image(from texture: MTLTexture) -> NSImage {
    let width = texture.width, height = texture.height
    // The total number of bytes of the texture
    let imageByteCount = width * height * 4
    // The number of bytes for each image row
    let bytesPerRow = width * 4
    // An empty buffer that will contain the image
    var src = [UInt8](repeating: 0, count: imageByteCount)
    // Gets the bytes from the texture
    let region = MTLRegionMake2D(0, 0, width, height)
    texture.getBytes(&src, bytesPerRow: bytesPerRow, from: region, mipmapLevel: 0)
    
    // Creates an image context
    let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue))
    let bitsPerComponent = 8
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let context = CGContext(data: &src,
                            width: width,
                            height: height,
                            bitsPerComponent: bitsPerComponent,
                            bytesPerRow: bytesPerRow,
                            space: colorSpace,
                            bitmapInfo: bitmapInfo.rawValue)!
    
    // Creates the image from the graphics context
    let dstImage = context.makeImage()!
    // Creates the final UIImage
    return NSImage(cgImage: dstImage, size: CGSize(width: dstImage.width, height: dstImage.height))
}
