//
//  Metal.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage
import Metal

let metalContext = MetalContext.shared
let ciContext = CIContext(mtlDevice: metalContext.device)

let inputImage = CIImage(named: "girl")
let width = Int(inputImage.extent.width)
let height = Int(inputImage.extent.height)

let transform = CGAffineTransform(translationX: CGFloat(-width), y: CGFloat(-height)).concatenating(CGAffineTransform(rotationAngle: .pi))
let outputImage = inputImage
    .applyingFilter("CICrystallize", parameters: [kCIInputCenterKey: CIVector(x: 320, y: 320), kCIInputRadiusKey: 20])
    .applyingFilter("CIAffineTransform", parameters: [kCIInputTransformKey: transform])

let textureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .bgra8Unorm,
                                                                 width: width,
                                                                 height: height,
                                                                 mipmapped: false)
textureDescriptor.usage = .shaderWrite
let outTexture = metalContext.makeTexture(descriptor: textureDescriptor)

let commandBuffer = metalContext.makeCommandBuffer()
let bounds = inputImage.extent
let colorSpace = CGColorSpaceCreateDeviceRGB()
ciContext.render(outputImage,
                 to: outTexture,
                 commandBuffer: commandBuffer,
                 bounds: bounds,
                 colorSpace: colorSpace)
commandBuffer.commit()
commandBuffer.waitUntilCompleted()

image(from: outTexture)

//: [Next](@next)
