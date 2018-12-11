//
//  HighPassSkinSmoothingMaskGeneratorFilter.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class HighPassSkinSmoothingMaskGeneratorFilter: CIFilter {
    @objc public var inputImage: CIImage?
    @objc public var inputRadius: Float = 8.0
    
    public override func setDefaults() {
        inputRadius = 8.0
    }
    
    public override var outputImage: CIImage! {
        guard let inputImage = inputImage else { return nil }
        
        let exposureFilter = CIFilter(name: "CIExposureAdjust", parameters: [
            kCIInputImageKey: inputImage, kCIInputEVKey: -1.0
        ])!
        
        let blendFilter = GreenBlueChannelOverlayBlendFilter()
        blendFilter.inputImage = exposureFilter.outputImage
        
        let highPassFilter = HighPassFilter()
        highPassFilter.inputImage = blendFilter.outputImage
        highPassFilter.inputRadius = inputRadius
        
        let hardLightFilter = HighPassSkinSmoothingMaskBoostFilter()
        hardLightFilter.inputImage = highPassFilter.outputImage
        return hardLightFilter.outputImage
    }
}
