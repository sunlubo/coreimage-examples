//
//  Filters.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class PolarPixellateFilter: CIFilter {
    static let kernel = CIWarpKernel(filename: "PolarPixellate")
    
    @objc public var inputImage: CIImage?
    @objc public var inputCenter: CIVector = CIVector(x: 320, y: 320)
    @objc public var inputPixelArc: CGFloat = .pi / 15
    @objc public var inputPixelLength: CGFloat = 50
    
    public override var attributes: [String: Any] {
        return [
            kCIAttributeFilterDisplayName: "Polar Pixellate",
            "inputImage": [
                kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage
            ],
            "inputPixelArc": [
                kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: CGFloat.pi / 15,
                kCIAttributeDisplayName: "Pixel Arc",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: CGFloat.pi,
                kCIAttributeType: kCIAttributeTypeScalar
            ],
            "inputPixelLength": [
                kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 50,
                kCIAttributeDisplayName: "Pixel Length",
                kCIAttributeMin: 1,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 250,
                kCIAttributeType: kCIAttributeTypeScalar
            ],
            "inputCenter": [
                kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIVector",
                kCIAttributeDisplayName: "Center",
                kCIAttributeDefault: CIVector(x: 320, y: 320),
                kCIAttributeType: kCIAttributeTypePosition
            ]
        ]
    }
    
    public override func setDefaults() {
        inputCenter = CIVector(x: 320, y: 320)
        inputPixelArc = .pi / 15
        inputPixelLength = 50
    }
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let dod = inputImage.extent
            let pixelSize = CIVector(x: inputPixelLength, y: inputPixelArc)
            return PolarPixellateFilter.kernel.apply(extent: dod,
                                                     roiCallback: { index, rect in rect },
                                                     image: inputImage,
                                                     arguments: [inputCenter, pixelSize])
        }
        return nil
    }
}

public final class MirrorXFilter: CIFilter {
    static let kernel = CIWarpKernel(filename: "MirrorX")
    
    @objc public var inputImage: CIImage?
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage, !inputImage.extent.isInfinite {
            let dod = inputImage.extent
            var result = inputImage.transformed(by: CGAffineTransform(translationX: -dod.origin.x, y: -dod.origin.y))
            result = MirrorXFilter.kernel.apply(extent: dod,
                                                roiCallback: { index, rect in rect },
                                                image: result,
                                                arguments: [dod.width])!
            return result.transformed(by: CGAffineTransform(translationX: dod.origin.x, y: dod.origin.y))
        }
        return nil
    }
}

public final class MirrorYFilter: CIFilter {
    static let kernel = CIWarpKernel(filename: "MirrorY")
    
    @objc public var inputImage: CIImage?
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage, !inputImage.extent.isInfinite {
            let dod = inputImage.extent
            var result = inputImage.transformed(by: CGAffineTransform(translationX: -dod.origin.x, y: -dod.origin.y))
            result = MirrorYFilter.kernel.apply(extent: dod,
                                                roiCallback: { index, rect in rect },
                                                image: result,
                                                arguments: [dod.height])!
            return result.transformed(by: CGAffineTransform(translationX: dod.origin.x, y: dod.origin.y))
        }
        return nil
    }
}
