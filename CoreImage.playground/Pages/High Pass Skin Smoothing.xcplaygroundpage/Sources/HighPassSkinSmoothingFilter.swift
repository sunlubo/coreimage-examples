//
//  HighPassSkinSmoothingFilter.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class HighPassSkinSmoothingFilter: CIFilter {
    @objc public var inputImage: CIImage?
    @objc public var inputAmount: Float = 0.75
    @objc public var inputRadius: Float = 8.0
    @objc public var inputToneCurveControlPoints: [CIVector] = [CIVector(x: 0, y: 0), CIVector(x: 120 / 255, y: 146 / 255), CIVector(x: 1, y: 1)]
    @objc public var inputSharpnessFactor: Float = 0.6
    
    public override func setDefaults() {
        inputAmount = 0.75
        inputRadius = 8.0
        inputToneCurveControlPoints = [CIVector(x: 0, y: 0), CIVector(x: 120 / 255, y: 146 / 255), CIVector(x: 1, y: 1)]
        inputSharpnessFactor = 0.6
    }
    
    public override var outputImage: CIImage! {
        guard let inputImage = inputImage else { return nil }
        
        let maskGenerator = HighPassSkinSmoothingMaskGeneratorFilter()
        maskGenerator.inputImage = inputImage
        maskGenerator.inputRadius = inputRadius
        
        let skinToneCurveFilter = RGBToneCurveFilter()
        skinToneCurveFilter.inputImage = inputImage
        skinToneCurveFilter.inputRGBCompositeControlPoints = inputToneCurveControlPoints
        skinToneCurveFilter.inputIntensity = inputAmount
        
        let blendWithMaskFilter = CIFilter(name: "CIBlendWithMask", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputBackgroundImageKey: skinToneCurveFilter.outputImage,
            kCIInputMaskImageKey: maskGenerator.outputImage
        ])!
        
        let sharpness = inputSharpnessFactor * inputAmount
        if sharpness > 0 {
            return blendWithMaskFilter.outputImage?.applyingFilter("CISharpenLuminance", parameters: [kCIInputSharpnessKey: sharpness])
        }
        return blendWithMaskFilter.outputImage
    }
}
