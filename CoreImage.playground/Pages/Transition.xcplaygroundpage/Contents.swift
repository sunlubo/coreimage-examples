//
//  Transition.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import Cocoa
import CoreImage
import simd
import CoreMedia
import Dispatch
import PlaygroundSupport

// Transitions between images, such as dissolve, disintegrate with mask, swipe
CIFilter.filterNames(inCategory: kCICategoryTransition).forEach { print($0) }

let inputImage = CIImage(named: "girl")
let inputTargetImage = CIImage(named: "sunset")
showImage(image: inputImage, extent: inputImage.extent)
showImage(image: inputTargetImage, extent: inputTargetImage.extent)

// Transitions from one image to another of differing dimensions by unfolding and crossfading.
var filter = CIFilter(name: "CIAccordionFoldTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    "inputBottomHeight": 0.0,
    "inputNumberOfFolds": 3.0,
    "inputFoldShadowAmount": 0.1,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by passing a bar over the source image.
filter = CIFilter(name: "CIBarsSwipeTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputAngleKey: 3.14,
    kCIInputWidthKey: 30.0,
    "inputBarOffset": 10.0,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by simulating the effect of a copy machine.
filter = CIFilter(name: "CICopyMachineTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 200, w: 200),
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    kCIInputAngleKey: 0.0,
    kCIInputWidthKey: 200.0,
    kCIInputOpacityKey: 1.3,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another using the shape defined by a mask.
filter = CIFilter(name: "CIDisintegrateWithMaskTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    "inputMaskImage": inputImage,
    "inputShadowRadius": 8.0,
    "inputShadowDensity": 0.65,
    "inputShadowOffset": CIVector(x: 0, y: -10),
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Uses a dissolve to transition from one image to another.
filter = CIFilter(name: "CIDissolveTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by creating a flash.
filter = CIFilter(name: "CIFlashTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 640, w: 640),
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    "inputMaxStriationRadius": 2.58,
    "inputStriationStrength": 0.50,
    "inputStriationContrast": 1.38,
    "inputFadeThreshold": 0.85,
    kCIInputTimeKey: 0.6
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by revealing the target image through irregularly shaped holes.
filter = CIFilter(name: "CIModTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputAngleKey: 2.0,
    kCIInputRadiusKey: 150.0,
    "inputCompression": 300.0,
    kCIInputTimeKey: 0.6
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by simulating a curling page, revealing the new image as the page curls.
filter = CIFilter(name: "CIPageCurlTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    "inputBacksideImage": CIImage(named: "sunflower"),
    kCIInputShadingImageKey: CIImage(named: "monalisa"),
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 640, w: 640),
    kCIInputAngleKey: Float.pi / 4,
    kCIInputRadiusKey: 100.0,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by simulating a curling page, revealing the new image as the page curls.
filter = CIFilter(name: "CIPageCurlWithShadowTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    "inputBacksideImage": CIImage(named: "sunflower"),
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 0, w: 0),
    kCIInputAngleKey: Float.pi / 4,
    kCIInputRadiusKey: 100.0,
    "inputShadowSize": 0.5,
    "inputShadowAmount": 0.7,
    "inputShadowExtent": CIVector(x: 0, y: 0, z: 0, w: 0),
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by creating a circular wave that expands from the center point, revealing the new image in the wake of the wave.
filter = CIFilter(name: "CIRippleTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputShadingImageKey: CIImage(),
    kCIInputCenterKey: CIVector(x: 320, y: 320),
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 640, w: 640),
    kCIInputWidthKey: 100.0,
    kCIInputScaleKey: 50.0,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// Transitions from one image to another by simulating a swiping action.
filter = CIFilter(name: "CISwipeTransition", parameters: [
    kCIInputImageKey: inputImage,
    kCIInputTargetImageKey: inputTargetImage,
    kCIInputExtentKey: CIVector(x: 0, y: 0, z: 640, w: 640),
    kCIInputColorKey: CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    kCIInputAngleKey: Float.pi / 4,
    kCIInputWidthKey: 300.0,
    kCIInputOpacityKey: 0.0,
    kCIInputTimeKey: 0.5
])!
showImage(filter: filter, extent: inputImage.extent)

// MARK: - Animation

let imageView = NSImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
PlaygroundPage.current.liveView = imageView

let interval = CMTime(value: 1, timescale: 60).seconds
var time = 0.0
let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
timer.setEventHandler {
    time += interval
    if time > 1 {
        timer.cancel()
    }
    else {
        let filter = CIFilter(name: "CIBarsSwipeTransition", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputTargetImageKey: inputTargetImage,
            kCIInputAngleKey: 3.14,
            kCIInputWidthKey: 30.0,
            "inputBarOffset": 10.0,
            kCIInputTimeKey: time
        ])!
        imageView.image = showImage(filter: filter)
    }
}
timer.schedule(deadline: .now(), repeating: interval)
timer.resume()

//: [Next](@next)
