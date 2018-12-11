//
//  GreenBlueChannelOverlayBlendFilter.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class GreenBlueChannelOverlayBlendFilter: CIFilter {
    static let kernel = CIColorKernel(filename: "GreenBlueChannelOverlayBlend")

    @objc public var inputImage: CIImage?

    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return GreenBlueChannelOverlayBlendFilter.kernel.apply(extent: inputImage.extent, arguments: [inputImage])
        }
        return nil
    }
}
