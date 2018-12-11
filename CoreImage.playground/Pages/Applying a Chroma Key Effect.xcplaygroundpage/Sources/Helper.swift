//
//  Helper.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Cocoa
import CoreImage

public func chromaKeyFilter(fromHue: CGFloat, toHue: CGFloat) -> CIFilter? {
    let size = 64
    var cubeRGB = [Float]()

    for z in 0 ..< size {
        let blue = CGFloat(z) / CGFloat(size - 1)
        for y in 0 ..< size {
            let green = CGFloat(y) / CGFloat(size - 1)
            for x in 0 ..< size {
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

    let data = Data(buffer: UnsafeBufferPointer(start: &cubeRGB, count: cubeRGB.count))
    return CIFilter(name: "CIColorCube", parameters: ["inputCubeDimension": size, "inputCubeData": data])
}
