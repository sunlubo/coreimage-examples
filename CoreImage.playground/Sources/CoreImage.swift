//
//  CoreImage.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Cocoa
import CoreImage

public let context = CIContext(options: [
    .workingColorSpace: CGColorSpace(name: CGColorSpace.sRGB)!
])

public let kCIInputModelKey = "inputModel"
public let kCIInputValueKey = "inputValue"
public let kCIInputSoftnessKey = "inputSoftness"
public let kCIInputDitherKey = "inputDither"
public let kCIInputMeshKey = "inputMesh"
public let kCIInputTextKey = "inputText"
public let kCIInputScaleFactorKey = "inputScaleFactor"
public let kCIInputHeightKey = "inputHeight"
public let kCIInputLowLimitKey = "inputLowLimit"
public let kCIInputHighLimitKey = "inputHighLimit"
public let kCIInputMessageKey = "inputMessage"
public let kCIInputLevelsKey = "inputLevels"
public let kCIInputCountKey = "inputCount"
public let kCIInputAcuteAngleKey = "inputAcuteAngle"
public let kCIInputSizeKey = "inputSize"
public let kCIInputCubeDataKey = "inputCubeData"
public let kCIInputCubeDimensionKey = "inputCubeDimension"
public let kCIInputCurvesDomainKey = "inputCurvesDomain"
public let kCIInputCurvesDataKey = "inputCurvesData"
public let kCIInputColorSpaceKey = "inputColorSpace"
public let kCIInputRotationKey = "inputRotation"
public let kCIInputDecayKey = "inputDecay"
public let kCIInputTopLeftKey = "inputTopLeft"
public let kCIInputTopRightKey = "inputTopRight"
public let kCIInputBottomRightKey = "inputBottomRight"
public let kCIInputBottomLeftKey = "inputBottomLeft"
public let kCIInputRectangleKey = "inputRectangle"
public let kCIInputOpacityKey = "inputOpacity"
public let kCIInputPowerKey = "inputPower"
public let kCIInputTextureKey = "inputTexture"
public let kCIInputNeutralKey = "inputNeutral"
public let kCIInputTargetNeutralKey = "inputTargetNeutral"
public let kCIInputMinComponentsKey = "inputMinComponents"
public let kCIInputMaxComponentsKey = "inputMaxComponents"
public let kCIInputRedCoefficientsKey = "inputRedCoefficients"
public let kCIInputGreenCoefficientsKey = "inputGreenCoefficients"
public let kCIInputBlueCoefficientsKey = "inputBlueCoefficients"
public let kCIInputAlphaCoefficientsKey = "inputAlphaCoefficients"
public let kCIInputColor0Key = "inputColor0"
public let kCIInputColor1Key = "inputColor1"
public let kCIInputPointKey = "inputPoint"
public let kCIInputPoint0Key = "inputPoint0"
public let kCIInputPoint1Key = "inputPoint1"
public let kCIInputPoint2Key = "inputPoint2"
public let kCIInputPoint3Key = "inputPoint3"
public let kCIInputPoint4Key = "inputPoint4"
public let kCIInputImage2Key = "inputImage2"
public let kCIInputRadius0Key = "inputRadius0"
public let kCIInputRadius1Key = "inputRadius1"

extension CGImage {

    public static func image(named name: String) -> CGImage {
        return NSImage(named: name)!.cgImage(forProposedRect: nil, context: nil, hints: nil)!
    }
}

extension CIImage {

    public convenience init(named name: String, options: [CIImageOption: Any] = [.applyOrientationProperty: true]) {
        let cgImage = NSImage(named: name)!.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        self.init(cgImage: cgImage, options: options)
    }
}

extension CIFilter {

    public func printInputAttributes() {
        print(attributes.filter({ inputKeys.contains($0.key) }))
    }
}

extension CIKernel {

    public convenience init(filename: String) {
        let source = try! String(contentsOf: Bundle.main.url(forResource: filename, withExtension: "cikernel")!)
        self.init(source: source)!
    }
}

extension CIVector {

    public convenience init(values: [CGFloat]) {
        self.init(values: values, count: values.count)
    }

    public convenience init(rect: CGRect) {
        self.init(x: rect.origin.x, y: rect.origin.y, z: rect.size.width, w: rect.size.height)
    }

    public func normalize() -> CIVector {
        var sum = 0 as CGFloat
        for i in 0 ..< count {
            sum += value(at: i)
        }
        if sum == 0 {
            return self
        }
        var normalizedValues = [CGFloat]()
        for i in 0 ..< count {
            normalizedValues.append(value(at: i) / sum)
        }
        return CIVector(values: normalizedValues, count: normalizedValues.count)
    }
}

public func colorImage(color: CIColor, size: CGSize) -> CIImage {
    return CIFilter(name: "CIConstantColorGenerator", parameters: [kCIInputColorKey: color])!
        .outputImage!
        .cropped(to: CGRect(origin: .zero, size: size))
}

public func showImage(image: CIImage) -> NSImage {
    return NSImage(cgImage: context.createCGImage(image, from: image.extent)!, size: NSZeroSize)
}

public func showImage(image: CIImage, extent: CGRect) -> NSImage {
    return NSImage(cgImage: context.createCGImage(image, from: extent)!, size: NSZeroSize)
}

public func showImage(filter: CIFilter) -> NSImage {
    let outputImage = filter.outputImage!
    return NSImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!, size: NSZeroSize)
}

public func showImage(filter: CIFilter, extent: CGRect) -> NSImage {
    return NSImage(cgImage: context.createCGImage(filter.outputImage!, from: extent)!, size: NSZeroSize)
}

public func showColor(filter: CIFilter) -> NSColor {
    let image = filter.outputImage!
    let extent = image.extent
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let rowBytes = Int(extent.width) * 4
    let totalBytes = rowBytes * Int(extent.height)
    let bitmap = UnsafeMutablePointer<UInt8>.allocate(capacity: totalBytes)
    bitmap.initialize(to: 0)
    defer {
        bitmap.deallocate()
    }
    context.render(image, toBitmap: bitmap, rowBytes: rowBytes, bounds: extent, format: .RGBA8, colorSpace: colorSpace)
    let r = CGFloat(bitmap[0]) / 255
    let g = CGFloat(bitmap[1]) / 255
    let b = CGFloat(bitmap[2]) / 255
    let a = CGFloat(bitmap[3]) / 255
    return NSColor(red: r, green: g, blue: b, alpha: a)
}

public func showHistogram(filter: CIFilter) -> NSImage {
    let filter = CIFilter(name: "CIHistogramDisplayFilter", parameters: [
        kCIInputImageKey: filter.outputImage!,
        kCIInputHeightKey: 200,
        kCIInputLowLimitKey: 0.0,
        kCIInputHighLimitKey: 1.0
    ])!
    return showImage(filter: filter)
}
