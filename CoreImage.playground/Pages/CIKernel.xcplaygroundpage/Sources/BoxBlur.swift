//
//  BoxBlur.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class BoxBlurFilter: CIFilter {
    static let kernel = CIKernel(filename: "BoxBlur")

    @objc public var inputImage: CIImage?
    @objc public var inputRadius: CGFloat = 20.0

    public override func setDefaults() {
        inputRadius = 20.0
    }

    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let blurRadius = inputRadius
            let arguments = [inputImage, blurRadius] as [Any]
            return BoxBlurFilter.kernel.apply(extent: inputImage.extent,
                                              roiCallback: { index, rect in
                                                  return rect.insetBy(dx: -blurRadius, dy: -blurRadius)
                                              },
                                              arguments: arguments)
        }
        return nil
    }
}
