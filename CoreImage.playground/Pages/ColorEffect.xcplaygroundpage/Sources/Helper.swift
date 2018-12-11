//
//  Helper.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Cocoa

public struct RGB {
    public let a: UInt8
    public let r: UInt8
    public let g: UInt8
    public let b: UInt8

    public var luma: UInt8 {
        return UInt8((Double(r) * 0.2126) + (Double(g) * 0.7152) + (Double(b) * 0.0722))
    }

    public init(r: UInt8, g: uint8, b: UInt8, a: UInt8 = 255) {
        self.a = a
        self.r = r
        self.g = g
        self.b = b
    }
}

// ZX Spectrum Dim
public let dimSpectrumColors = [
    RGB(r: 0x00, g: 0x00, b: 0x00),
    RGB(r: 0x00, g: 0x00, b: 0xCD),
    RGB(r: 0xCD, g: 0x00, b: 0x00),
    RGB(r: 0xCD, g: 0x00, b: 0xCD),
    RGB(r: 0x00, g: 0xCD, b: 0x00),
    RGB(r: 0x00, g: 0xCD, b: 0xCD),
    RGB(r: 0xCD, g: 0xCD, b: 0x00),
    RGB(r: 0xCD, g: 0xCD, b: 0xCD)
]

// ZX Spectrum Bright
public let brightSpectrumColors = [
    RGB(r: 0x00, g: 0x00, b: 0x00),
    RGB(r: 0x00, g: 0x00, b: 0xFF),
    RGB(r: 0xFF, g: 0x00, b: 0x00),
    RGB(r: 0xFF, g: 0x00, b: 0xFF),
    RGB(r: 0x00, g: 0xFF, b: 0x00),
    RGB(r: 0x00, g: 0xFF, b: 0xFF),
    RGB(r: 0xFF, g: 0xFF, b: 0x00),
    RGB(r: 0xFF, g: 0xFF, b: 0xFF)
]

// VIC-20
public let vic20Colors = [
    RGB(r: 0, g: 0, b: 0),
    RGB(r: 255, g: 255, b: 255),
    RGB(r: 141, g: 62, b: 55),
    RGB(r: 114, g: 193, b: 200),
    RGB(r: 128, g: 52, b: 139),
    RGB(r: 85, g: 160, b: 73),
    RGB(r: 64, g: 49, b: 141),
    RGB(r: 170, g: 185, b: 93),
    RGB(r: 139, g: 84, b: 41),
    RGB(r: 213, g: 159, b: 116),
    RGB(r: 184, g: 105, b: 98),
    RGB(r: 135, g: 214, b: 221),
    RGB(r: 170, g: 95, b: 182),
    RGB(r: 148, g: 224, b: 137),
    RGB(r: 128, g: 113, b: 204),
    RGB(r: 191, g: 206, b: 114)
]

// C-64
public let c64Colors = [
    RGB(r: 0, g: 0, b: 0),
    RGB(r: 255, g: 255, b: 255),
    RGB(r: 136, g: 57, b: 50),
    RGB(r: 103, g: 182, b: 189),
    RGB(r: 139, g: 63, b: 150),
    RGB(r: 85, g: 160, b: 73),
    RGB(r: 64, g: 49, b: 141),
    RGB(r: 191, g: 206, b: 114),
    RGB(r: 139, g: 84, b: 41),
    RGB(r: 87, g: 66, b: 0),
    RGB(r: 184, g: 105, b: 98),
    RGB(r: 80, g: 80, b: 80),
    RGB(r: 120, g: 120, b: 120),
    RGB(r: 148, g: 224, b: 137),
    RGB(r: 120, g: 105, b: 196),
    RGB(r: 159, g: 159, b: 159)
]

// Apple II
public let appleIIColors = [
    RGB(r: 0, g: 0, b: 0),
    RGB(r: 114, g: 38, b: 64),
    RGB(r: 64, g: 51, b: 127),
    RGB(r: 228, g: 52, b: 254),
    RGB(r: 14, g: 89, b: 64),
    RGB(r: 128, g: 128, b: 128),
    RGB(r: 27, g: 154, b: 254),
    RGB(r: 191, g: 179, b: 255),
    RGB(r: 64, g: 76, b: 0),
    RGB(r: 228, g: 101, b: 1),
    RGB(r: 128, g: 128, b: 128),
    RGB(r: 241, g: 166, b: 191),
    RGB(r: 27, g: 203, b: 1),
    RGB(r: 191, g: 204, b: 128),
    RGB(r: 141, g: 217, b: 191),
    RGB(r: 255, g: 255, b: 255)
]

public struct CurvesRGB {
    public let r: Float32
    public let g: Float32
    public let b: Float32

    public init(r: Float32, g: Float32, b: Float32) {
        self.r = r
        self.g = g
        self.b = b
    }
}

public struct InputCurves {
    public let shadows: CurvesRGB
    public let midtones: CurvesRGB
    public let highlights: CurvesRGB

    public init(shadows: CurvesRGB, midtones: CurvesRGB, highlights: CurvesRGB) {
        self.shadows = shadows
        self.midtones = midtones
        self.highlights = highlights
    }
}

public func colorMapGradientFromColors(_ colors: [RGB]) -> CIImage {
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)
    let bitsPerComponent = 8
    let bitsPerPixel = 32
    var sortedColors = colors
        .sorted(by: { $0.luma < $1.luma })
        .flatMap({ [RGB](repeating: $0, count: 16) })
    let width = sortedColors.count
    let dataProvider = CGDataProvider(data: NSData(bytes: &sortedColors, length: sortedColors.count * MemoryLayout<RGB>.size))!
    let cgImage = CGImage(
        width: width,
        height: 1,
        bitsPerComponent: bitsPerComponent,
        bitsPerPixel: bitsPerPixel,
        bytesPerRow: width * MemoryLayout<RGB>.size,
        space: rgbColorSpace,
        bitmapInfo: bitmapInfo,
        provider: dataProvider,
        decode: nil,
        shouldInterpolate: true,
        intent: .defaultIntent
    )!
    return CIImage(cgImage: cgImage)
}

public func colorCube(size: Int, fromHue: CGFloat, toHue: CGFloat) -> Data {
    var cubeRGB = [Float]()
    for z in 0..<size {
        let blue = CGFloat(z) / CGFloat(size - 1)
        for y in 0..<size {
            let green = CGFloat(y) / CGFloat(size - 1)
            for x in 0..<size {
                let red = CGFloat(x) / CGFloat(size - 1)
                let hue = NSColor(red: red, green: green, blue: blue, alpha: 1).hueComponent
                let alpha: CGFloat = (hue >= fromHue && hue <= toHue) ? 0 : 1
                cubeRGB.append(Float(red * alpha))
                cubeRGB.append(Float(green * alpha))
                cubeRGB.append(Float(blue * alpha))
                cubeRGB.append(Float(alpha))
            }
        }
    }
    return Data(buffer: UnsafeBufferPointer(start: &cubeRGB, count: cubeRGB.count))
}

public func bitmap(from image: CGImage) -> UnsafePointer<UInt8> {
    let width = image.width
    let height = image.height
    let bytesPerRow = image.bytesPerRow
    let totalSize = bytesPerRow * height
    let pixels = UnsafeMutablePointer<UInt8>.allocate(capacity: totalSize)
    pixels.initialize(repeating: 0, count: totalSize)
    let bitmapInfo = image.bitmapInfo
    let context = CGContext(data: pixels,
                            width: width,
                            height: height,
                            bitsPerComponent: 8,
                            bytesPerRow: bytesPerRow,
                            space: CGColorSpaceCreateDeviceRGB(),
                            bitmapInfo: bitmapInfo.rawValue)!
    context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
    return UnsafePointer(pixels)
}

// https://github.com/huangtw/ColorLUT/blob/master/ColorLUT/CIFilter%2BColorLUT.m
public func colorCubeFromImage(_ image: CGImage, size: Int = 64) -> Data {
    let width = image.width
    let height = image.height
    let rows = width / size
    let cols = height / size
    let pixels = bitmap(from: image)
    defer {
        pixels.deallocate()
    }
    var cube = [Float](repeating: 0, count: size * size * size * 4)

    var bitmapOffest = 0
    var z = 0
    for _ in 0..<rows { // 0..<8
        for y in 0..<size { // 0..<64
            let tmp = z
            for _ in 0..<cols { // 0..<8
                for x in 0..<size { // 0..<64
                    let r = pixels[bitmapOffest]
                    let g = pixels[bitmapOffest + 1]
                    let b = pixels[bitmapOffest + 2]
                    let a = pixels[bitmapOffest + 3]

                    let dataOffset = (z * size * size + y * size + x) * 4

                    cube[dataOffset + 0] = Float(r) / 255
                    cube[dataOffset + 1] = Float(g) / 255
                    cube[dataOffset + 2] = Float(b) / 255
                    cube[dataOffset + 3] = Float(a) / 255

                    bitmapOffest += 4
                }
                z += 1
            }
            z = tmp
        }
        z += cols
    }

    return Data(buffer: UnsafeBufferPointer(start: &cube, count: cube.count))
}

public func generateLoockupTexture() -> CGImage {
    let width = 64 * 8
    let height = 64 * 8
    let bytesPerRow = width * 4
    let totalSize = bytesPerRow * height
    let pixels = UnsafeMutablePointer<UInt8>.allocate(capacity: totalSize)
    pixels.initialize(repeating: 0, count: totalSize)
    defer {
        pixels.deallocate()
    }
    for row in 0..<8 {
        for col in 0..<8 {
            for g in 0..<64 {
                for r in 0..<64 {
                    let pos = (g + row * 64) * bytesPerRow + (r + col * 64) * 4
                    pixels[pos + 0] = UInt8(Float(r) * 255 / 63 + 0.5)
                    pixels[pos + 1] = UInt8(Float(g) * 255 / 63 + 0.5)
                    pixels[pos + 2] = UInt8(Float(row * 8 + col) * 255 / 63 + 0.5)
                    pixels[pos + 3] = UInt8(255)
                }
            }
        }
    }
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: pixels,
                            width: width,
                            height: height,
                            bitsPerComponent: 8,
                            bytesPerRow: bytesPerRow,
                            space: colorSpace,
                            bitmapInfo: bitmapInfo.rawValue)!
    return context.makeImage()!
}
