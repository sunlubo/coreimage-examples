//
//  Gradient.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage

// Gradient, such as axial, radial, Gaussian
CIFilter.filterNames(inCategory: kCICategoryGradient).forEach { print($0) }

let extent = CGRect(x: 0, y: 0, width: 200, height: 200)

// Generates a gradient that varies from one color to another using a Gaussian distribution.
var filter = CIFilter(name: "CIGaussianGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 150, y: 150),
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0),
    kCIInputRadiusKey: 300.0
])!
showImage(filter: filter, extent: extent)

//
let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) ?? CGColorSpaceCreateDeviceRGB()
filter = CIFilter(name: "CIHueSaturationValueGradient", parameters: [
    kCIInputRadiusKey: 100,
    kCIInputColorSpaceKey: colorSpace,
    kCIInputValueKey: 1.0,
    kCIInputSoftnessKey: 1.0,
    kCIInputDitherKey: 1.0,
])!
showImage(filter: filter)

// Generates a gradient that varies along a linear axis between two defined endpoints.
filter = CIFilter(name: "CILinearGradient", parameters: [
    kCIInputPoint0Key: CIVector(x: 0, y: 0),
    kCIInputPoint1Key: CIVector(x: 200, y: 200),
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0)
])!
showImage(filter: filter, extent: extent)

// Generates a gradient that varies radially between two circles having the same center.
filter = CIFilter(name: "CIRadialGradient", parameters: [
    kCIInputCenterKey: CIVector(x: 100, y: 100),
    kCIInputRadius0Key: 50.0,
    kCIInputRadius1Key: 100.0,
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0)
])!
showImage(filter: filter, extent: extent)

// Generates a gradient that uses an S-curve function to blend colors along a linear axis between two defined endpoints.
filter = CIFilter(name: "CISmoothLinearGradient", parameters: [
    kCIInputPoint0Key: CIVector(x: 0, y: 0),
    kCIInputPoint1Key: CIVector(x: 200, y: 200),
    kCIInputColor0Key: CIColor(red: 0.0, green: 0.0, blue: 1.0),
    kCIInputColor1Key: CIColor(red: 0.0, green: 1.0, blue: 0.0)
])!
showImage(filter: filter, extent: extent)

//: [Next](@next)
