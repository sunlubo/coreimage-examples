//
//  Lookup.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class LookupFilter: CIFilter {
    let kernel = CIKernel(filename: "Lookup")

    @objc public var inputImage: CIImage?
    @objc public var inputLookupImage: CIImage?
    @objc public var inputIntensity: CGFloat = 1.0

    public override func setDefaults() {
        inputIntensity = 1.0
    }

    public override var outputImage: CIImage! {
        if let inputImage = inputImage, let inputLookupImage = inputLookupImage {
            let arguments = [inputImage, inputLookupImage, inputIntensity] as [Any]
            return kernel.apply(extent: inputImage.extent, roiCallback: { index, rect in index == 0 ? rect : inputLookupImage.extent }, arguments: arguments)
        }
        return nil
    }
}
