//
//  Filters.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class VintageVignette: CIFilter {
    @objc public var inputImage: CIImage?
    @objc public var inputVignetteIntensity: CGFloat = 1
    @objc public var inputVignetteRadius: CGFloat = 1
    @objc public var inputSepiaToneIntensity: CGFloat = 1
    
    public override var attributes: [String: Any] {
        return [
            kCIAttributeFilterDisplayName: "Vintage Vignette",
            "inputImage": [
                kCIAttributeDisplayName: "Image",
                kCIAttributeClass: "CIImage",
                kCIAttributeType: kCIAttributeTypeImage,
                kCIAttributeIdentity: 0
            ],
            "inputVignetteIntensity": [
                kCIAttributeDisplayName: "Vignette Intensity",
                kCIAttributeClass: "NSNumber",
                kCIAttributeType: kCIAttributeTypeScalar,
                kCIAttributeIdentity: 0,
                kCIAttributeDefault: 1,
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 2
            ],
            "inputVignetteRadius": [
                kCIAttributeDisplayName: "Vignette Radius",
                kCIAttributeType: kCIAttributeTypeScalar,
                kCIAttributeClass: "NSNumber",
                kCIAttributeIdentity: 0,
                kCIAttributeDefault: 1,
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 2
            ],
            "inputSepiaToneIntensity": [
                kCIAttributeDisplayName: "Sepia Tone Intensity",
                kCIAttributeType: kCIAttributeTypeScalar,
                kCIAttributeClass: "NSNumber",
                kCIAttributeIdentity: 0,
                kCIAttributeDefault: 1,
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 1
            ]
        ]
    }
    
    public override func setDefaults() {
        inputVignetteIntensity = 1
        inputVignetteRadius = 1
        inputSepiaToneIntensity = 1
    }
    
    public override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let finalImage = inputImage
            .applyingFilter("CIVignette", parameters: [
                kCIInputIntensityKey: inputVignetteIntensity,
                kCIInputRadiusKey: inputVignetteRadius
            ])
            .applyingFilter("CISepiaTone", parameters: [
                kCIInputIntensityKey: inputSepiaToneIntensity
            ])
        return finalImage
    }
}

public final class CustomFiltersVendor: CIFilterConstructor {
    
    public init() {}
    
    public func filter(withName name: String) -> CIFilter? {
        switch name {
        case "VintageVignette":
            return VintageVignette()
        default:
            return nil
        }
    }
}
