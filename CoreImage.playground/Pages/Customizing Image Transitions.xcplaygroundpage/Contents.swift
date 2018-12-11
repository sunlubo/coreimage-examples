//
//  Customizing Image Transitions.playground
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

// Transition between images in creative ways using Core Image filters.
//
// https://developer.apple.com/documentation/coreimage/customizing_image_transitions

let sourceImage = CIImage(named: "girl")
let destinationImage = CIImage(named: "sunset")

func dissolveFilter(_ inputImage: CIImage, to targetImage: CIImage, time: TimeInterval) -> CIImage {
    let inputTime = simd_smoothstep(0, 1, time)
    let filter = CIFilter(name: "CIDissolveTransition", parameters: [
        kCIInputImageKey: inputImage,
        kCIInputTargetImageKey: targetImage,
        kCIInputTimeKey: inputTime
    ])!
    return filter.outputImage!
}

func pixelateFilter(_ inputImage: CIImage, time: TimeInterval) -> CIImage {
    let inputScale = simd_smoothstep(1, 0, abs(time))
    let filter = CIFilter(name: "CIPixellate", parameters: [
        kCIInputImageKey: inputImage,
        kCIInputScaleKey: inputScale
    ])!
    return filter.outputImage!
}

let imageView = NSImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
PlaygroundPage.current.liveView = imageView

let interval = CMTime(value: 1, timescale: 60).seconds
var time = 0.0
let dt = interval
let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
timer.setEventHandler {
    time += dt
    if time > 1 {
        timer.cancel()
    }
    else {
        let dissolvedImage = dissolveFilter(sourceImage, to: destinationImage, time: time)
        let pixelatedImage = pixelateFilter(dissolvedImage, time: time)
        imageView.image = showImage(image: pixelatedImage)
    }
}
timer.schedule(deadline: .now(), repeating: interval)
timer.resume()

//: [Next](@next)
