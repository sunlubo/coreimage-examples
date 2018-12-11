//
//  Detector.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

//: [Previous](@previous)

import Foundation
import CoreImage

// Face
let faceImage = CIImage(named: "girl")
let faceOptions = [
    CIDetectorAccuracy: CIDetectorAccuracyHigh
] as [String: Any]
let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: faceOptions)!
let faceFeatures = faceDetector.features(in: faceImage) as! [CIFaceFeature]
var result = faceImage
for feature in faceFeatures {
    if feature.hasLeftEyePosition {
        let x = feature.leftEyePosition.x - 40
        let y = feature.leftEyePosition.y - 20
        let overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)).cropped(to: CGRect(x: x, y: y, width: 80, height: 40))
        result = overlay.composited(over: result)
    }

    if feature.hasRightEyePosition {
        let x = feature.rightEyePosition.x - 40
        let y = feature.rightEyePosition.y - 20
        let overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)).cropped(to: CGRect(x: x, y: y, width: 80, height: 40))
        result = overlay.composited(over: result)
    }

    if feature.hasMouthPosition {
        let x = feature.mouthPosition.x - 40
        let y = feature.mouthPosition.y - 20
        let overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)).cropped(to: CGRect(x: x, y: y, width: 80, height: 40))
        result = overlay.composited(over: result)
    }
}
showImage(image: result)

// Rectangle
let rectangleImage = CIImage(named: "rectangle")
let rectangleOptions = [
    CIDetectorAccuracy: CIDetectorAccuracyHigh,
    CIDetectorMaxFeatureCount: 3
] as [String: Any]
let rectangleDetector = CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: rectangleOptions)!
let rectangleFeatures = rectangleDetector.features(in: rectangleImage) as! [CIRectangleFeature]
result = rectangleImage
for feature in rectangleFeatures {
    let overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)).cropped(to: feature.bounds)
    result = overlay.composited(over: result)
}
showImage(image: result)

// QRCode
let qrImage = CIImage(named: "qrcode")
let qrOptions = [
    CIDetectorAccuracy: CIDetectorAccuracyHigh
] as [String: Any]
let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: qrOptions)!
let qrFeatures = qrDetector.features(in: qrImage) as! [CIQRCodeFeature]
result = qrImage
for feature in qrFeatures {
    print(feature.messageString!)

    let overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)).cropped(to: feature.bounds)
    result = overlay.composited(over: result)
}
showImage(image: result)

// Text
let textImage = CIImage(named: "text")
let textOptions = [
    CIDetectorAccuracy: CIDetectorAccuracyHigh,
    CIDetectorMaxFeatureCount: 256
] as [String: Any]
let textDetector = CIDetector(ofType: CIDetectorTypeText, context: nil, options: textOptions)!
let textFeatures = textDetector.features(in: textImage) as! [CITextFeature]
result = textImage
for feature in textFeatures {
    let overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)).cropped(to: feature.bounds)
    result = overlay.composited(over: result)
}
showImage(image: result)

//: [Next](@next)
