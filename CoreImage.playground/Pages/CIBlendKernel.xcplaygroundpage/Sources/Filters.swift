//
//  Filters.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

// https://github.com/BradLarson/GPUImage/blob/master/framework/Source/GPUImageDissolveBlendFilter.m
public final class DissolveBlendFilter: CIFilter {
    let kernel = CIBlendKernel(source: """
        kernel vec4 dissolveBlend(__sample foreground, __sample background) {
            return mix(foreground, background, 0.5);
        }
    """)
    
    @objc public var inputImage: CIImage?
    @objc public var inputBackgroundImage: CIImage?
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage, let inputBackgroundImage = inputBackgroundImage, let kernel = kernel {
            return kernel.apply(foreground: inputImage, background: inputBackgroundImage)
        }
        return nil
    }
}
