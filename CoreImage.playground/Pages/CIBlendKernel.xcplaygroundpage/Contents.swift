//
//  CIBlendKernel.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

let foregroundImage = CIImage(named: "girl")
let backgroundImage = CIImage(named: "sunset")

let filter = DissolveBlendFilter()
filter.inputImage = foregroundImage
filter.inputBackgroundImage = backgroundImage
showImage(filter: filter)

//: [Next](@next)
