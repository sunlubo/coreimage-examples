//
//  HighPassFilter.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class HighPassFilter: CIFilter {
    static let kernel = CIKernel(filename: "HighPass")
    
    @objc public var inputImage: CIImage?
    @objc public var inputRadius: Float = 20.0
    
    public override func setDefaults() {
        inputRadius = 20.0
    }
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let blurredImage = inputImage
                .clampedToExtent()
                .applyingFilter("CIGaussianBlur", parameters: [kCIInputRadiusKey: inputRadius])
                .cropped(to: inputImage.extent)
            return HighPassFilter.kernel.apply(extent: inputImage.extent,
                                               roiCallback: { index, rect in
                                                   return rect
                                               },
                                               arguments: [inputImage, blurredImage])
        }
        return nil
    }
}
