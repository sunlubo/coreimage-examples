//
//  Filters.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class ThresholdFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "Threshold")
    
    @objc public var inputImage: CIImage?
    @objc public var inputThreshold: CGFloat = 0.75
    
    public override func setDefaults() {
        inputThreshold = 0.75
    }
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return ThresholdFilter.kernel.apply(extent: inputImage.extent, arguments: [inputImage, inputThreshold])
        }
        return nil
    }
}

public final class SwapRedAndGreenFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "SwapRedAndGreen")
    
    @objc public var inputImage: CIImage?
    @objc public var inputAmount: CGFloat = 1.0
    
    public override func setDefaults() {
        inputAmount = 1.0
    }
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return SwapRedAndGreenFilter.kernel.apply(extent: inputImage.extent, arguments: [inputImage, inputAmount])
        }
        return nil
    }
}

public final class VignetteFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "Vignette")
    
    @objc public var inputImage: CIImage?
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let dod = inputImage.extent
            let radius = 0.5 * hypot(dod.size.width, dod.size.height)
            let centerOffset = CIVector(x: dod.size.width * 0.5 + dod.origin.x, y: dod.size.height * 0.5 + dod.origin.y)
            return VignetteFilter.kernel.apply(extent: dod, arguments: [inputImage, centerOffset, radius])
        }
        return nil
    }
}

public final class LuminanceFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "Luminance")
    
    @objc public var inputImage: CIImage?
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return LuminanceFilter.kernel.apply(extent: inputImage.extent, arguments: [inputImage])
        }
        return nil
    }
}

public final class VibranceFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "Vibrance")
    
    @objc public var inputImage: CIImage?
    /// The vibrance adjustment to apply, using 0.0 as the default, and a suggested min/max of around -1 and 1, respectively.
    @objc public var inputVibrance: Float = 0.0
    
    public override func setDefaults() {
        inputVibrance = 0.0
    }
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return VibranceFilter.kernel.apply(extent: inputImage.extent, arguments: [inputImage, inputVibrance])
        }
        return nil
    }
}
