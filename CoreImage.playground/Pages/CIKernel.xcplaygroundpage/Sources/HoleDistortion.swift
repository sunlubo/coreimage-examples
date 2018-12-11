//
//  HoleDistortion.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class HoleDistortion: CIFilter {
    static let kernel = CIKernel(filename: "HoleDistortion")
    
    @objc public var inputImage: CIImage?
    @objc public var inputCenter: CIVector = CIVector(x: 320, y: 320)
    @objc public var inputRadius: CGFloat = 20.0
    
    public override func setDefaults() {
        inputCenter = CIVector(x: 320, y: 320)
        inputRadius = 20.0
    }
    
    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let arguments = [inputImage, inputCenter, CIVector(x: 1.0 / inputRadius, y: inputRadius)] as [Any]
            return HoleDistortion.kernel.apply(extent: inputImage.extent, roiCallback: { index, rect in rect }, arguments: arguments)
        }
        return nil
    }
}
