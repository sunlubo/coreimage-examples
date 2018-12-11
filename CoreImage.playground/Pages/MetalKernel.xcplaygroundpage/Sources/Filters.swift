//
//  Filters.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

public final class MinimumComponentFilter: CIFilter {
    static let kernel = CIColorKernel(functionName: "minimumComponent")

    @objc public var inputImage: CIImage?

    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return MinimumComponentFilter.kernel.apply(extent: inputImage.extent,
                                                       roiCallback: { index, rect in
                                                           return rect
                                                       },
                                                       arguments: [inputImage])
        }
        return nil
    }
}

public final class MaximumComponentFilter: CIFilter {
    static let kernel = CIColorKernel(functionName: "maximumComponent")

    @objc public var inputImage: CIImage?

    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            return MaximumComponentFilter.kernel.apply(extent: inputImage.extent,
                                                       roiCallback: { index, rect in
                                                           return rect
                                                       },
                                                       arguments: [inputImage])
        }
        return nil
    }
}

@objc
public enum RGBFilterType: Int {
    case red
    case green
    case blue
}

public final class RGBFilter: CIFilter {
    static let redKernel = CIColorKernel(functionName: "red")
    static let greenKernel = CIColorKernel(functionName: "green")
    static let blueKernel = CIColorKernel(functionName: "blue")

    @objc public var inputImage: CIImage?
    @objc public var inputType: RGBFilterType = .red

    public override func setDefaults() {
        inputType = .red
    }

    public override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let kernel: CIKernel
            switch inputType {
            case .red:
                kernel = RGBFilter.redKernel
            case .green:
                kernel = RGBFilter.greenKernel
            case .blue:
                kernel = RGBFilter.blueKernel
            }
            return kernel.apply(extent: inputImage.extent,
                                roiCallback: { index, rect in
                                    return rect
                                },
                                arguments: [inputImage])
        }
        return nil
    }
}

public final class BoxBlurFilter: CIFilter {
    static let kernel = CIKernel(functionName: "boxBlur")

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
