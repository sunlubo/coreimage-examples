//
//  HighPassSkinSmoothingMaskBoostFilter.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class HighPassSkinSmoothingMaskBoostFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "HighPassSkinSmoothingMaskBoost")

    @objc public var inputImage: CIImage?

    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return HighPassSkinSmoothingMaskBoostFilter.kernel.apply(extent: inputImage.extent, arguments: [inputImage])
        }
        return nil
    }
}
