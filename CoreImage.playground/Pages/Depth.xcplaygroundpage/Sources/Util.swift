//
//  Util.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreFoundation
import ImageIO
import AVFoundation

public func depthDataForImage(_ name: String) -> AVDepthData {
    let imageURL = Bundle.main.urlForImageResource(name)!
    let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, nil)!
    // Read auxiliary data of type disparity
    let auxDataInfo = CGImageSourceCopyAuxiliaryDataInfoAtIndex(imageSource, 0, kCGImageAuxiliaryDataTypeDisparity) as? [AnyHashable: Any]
    // Create a depth data object from auxiliary data
    do {
        return try AVDepthData(fromDictionaryRepresentation: auxDataInfo!)
    } catch {
        fatalError(error.localizedDescription)
    }
}

extension CVPixelBuffer {
    
    public func normalize() {
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
        defer {
            CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
        }
        
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(self), to: UnsafeMutablePointer<Float>.self)
        
        var minPixel: Float = 1.0
        var maxPixel: Float = 0.0
        for y in 0 ..< height {
            for x in 0 ..< width {
                let pixel = floatBuffer[y * width + x]
                minPixel = min(pixel, minPixel)
                maxPixel = max(pixel, maxPixel)
            }
        }
        
        let range = maxPixel - minPixel
        for y in 0 ..< height {
            for x in 0 ..< width {
                let pixel = floatBuffer[y * width + x]
                floatBuffer[y * width + x] = (pixel - minPixel) / range
            }
        }
    }
    
    public func convertToDisparity32() -> CVPixelBuffer? {
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        
        var dispartyPixelBuffer: CVPixelBuffer?
        CVPixelBufferCreate(nil, width, height, kCVPixelFormatType_DisparityFloat32, nil, &dispartyPixelBuffer)
        guard let outputPixelBuffer = dispartyPixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(outputPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 1))
        defer {
            CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 1))
            CVPixelBufferUnlockBaseAddress(outputPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        }
        
        let outputBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(outputPixelBuffer), to: UnsafeMutablePointer<Float>.self)
        let inputBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(self), to: UnsafeMutablePointer<UInt8>.self)
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let pixel = inputBuffer[y * width + x]
                outputBuffer[y * width + x] = (Float(pixel) / Float(UInt8.max))
            }
        }
        
        return dispartyPixelBuffer
    }
}
