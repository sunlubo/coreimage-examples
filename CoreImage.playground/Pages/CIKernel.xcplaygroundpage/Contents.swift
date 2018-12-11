//
//  CIKernel.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let blurFilter = BoxBlurFilter()
blurFilter.inputImage = inputImage
blurFilter.inputRadius = 10
showImage(filter: blurFilter, extent: inputImage.extent)

let lookupFilter = LookupFilter()
lookupFilter.inputImage = CIImage(named: "girl")
lookupFilter.inputLookupImage = CIImage(named: "lut_amatorka")
// lookupFilter.inputLookupImage = CIImage(named: "lut_miss_etikate")
// lookupFilter.inputLookupImage = CIImage(named: "lut_soft_elegance_1")
// lookupFilter.inputLookupImage = CIImage(named: "lut_soft_elegance_2")
showImage(filter: lookupFilter)

let holeDistortion = HoleDistortion()
holeDistortion.inputImage = inputImage
holeDistortion.inputCenter = CIVector(x: 320, y: 320)
holeDistortion.inputRadius = 50
showImage(filter: holeDistortion)

//: [Next](@next)
