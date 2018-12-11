//
//  CIWrapKernel.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

let inputImage = CIImage(named: "girl")
showImage(image: inputImage, extent: inputImage.extent)

let polarPixellateFilter = PolarPixellateFilter()
polarPixellateFilter.inputImage = inputImage
polarPixellateFilter.inputPixelLength = 32
showImage(filter: polarPixellateFilter)

let mirrorXFilter = MirrorXFilter()
mirrorXFilter.inputImage = inputImage
showImage(filter: mirrorXFilter)

let mirrorYFilter = MirrorYFilter()
mirrorYFilter.inputImage = inputImage
showImage(filter: mirrorYFilter)

//: [Next](@next)
