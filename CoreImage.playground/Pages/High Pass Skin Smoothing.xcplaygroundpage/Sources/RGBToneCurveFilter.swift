//
//  RGBToneCurveFilter.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

// https://github.com/YuAo/Vivid/blob/master/Sources/YUCIRGBToneCurve.m
// https://github.com/BradLarson/GPUImage/blob/master/framework/Source/GPUImageToneCurveFilter.m
public final class RGBToneCurveFilter: CIFilter {
    static let kernel = CIKernel(filename: "RGBToneCurve")
    static let defaultControlPoints = [CIVector(x: 0.0, y: 0.0), CIVector(x: 0.5, y: 0.5), CIVector(x: 1.0, y: 1.0)]
    
    @objc public var inputImage: CIImage?
    
    @objc public var inputRedControlPoints: [CIVector] = RGBToneCurveFilter.defaultControlPoints
    @objc public var inputGreenControlPoints: [CIVector] = RGBToneCurveFilter.defaultControlPoints
    @objc public var inputBlueControlPoints: [CIVector] = RGBToneCurveFilter.defaultControlPoints
    @objc public var inputRGBCompositeControlPoints: [CIVector] = RGBToneCurveFilter.defaultControlPoints
    @objc public var inputIntensity: Float = 1.0
    
    var redCurve = [CGFloat]()
    var greenCurve = [CGFloat]()
    var blueCurve = [CGFloat]()
    var rgbCompositeCurve = [CGFloat]()
    
    public override func setDefaults() {
        inputRedControlPoints = RGBToneCurveFilter.defaultControlPoints
        inputGreenControlPoints = RGBToneCurveFilter.defaultControlPoints
        inputBlueControlPoints = RGBToneCurveFilter.defaultControlPoints
        inputRGBCompositeControlPoints = RGBToneCurveFilter.defaultControlPoints
        inputIntensity = 1.0
    }
    
    public override var outputImage: CIImage! {
        guard let inputImage = inputImage else { return nil }
        
        let toneCurveTexture = getToneCurveTexture()
        let arguments = [inputImage, toneCurveTexture, inputIntensity] as [Any]
        return RGBToneCurveFilter.kernel.apply(extent: inputImage.extent,
                                               roiCallback: { index, rect in
                                                   return index == 0 ? rect : toneCurveTexture.extent
                                               },
                                               arguments: arguments)
    }
    
    func getToneCurveTexture() -> CIImage {
        redCurve = getPreparedSplineCurve(points: inputRedControlPoints)
        greenCurve = getPreparedSplineCurve(points: inputGreenControlPoints)
        blueCurve = getPreparedSplineCurve(points: inputBlueControlPoints)
        rgbCompositeCurve = getPreparedSplineCurve(points: inputRGBCompositeControlPoints)
        
        let bitmap = UnsafeMutablePointer<UInt8>.allocate(capacity: 4 * 256)
        bitmap.initialize(to: 0)
        
        // BGRA for upload to texture
        for i in 0..<256 {
            let b = UInt8(min(max(CGFloat(i) + blueCurve[i], 0), 255))
            let g = UInt8(min(max(CGFloat(i) + greenCurve[i], 0), 255))
            let r = UInt8(min(max(CGFloat(i) + redCurve[i], 0), 255))
            bitmap[i * 4 + 0] = UInt8(min(max(CGFloat(b) + rgbCompositeCurve[Int(b)], 0), 255))
            bitmap[i * 4 + 1] = UInt8(min(max(CGFloat(g) + rgbCompositeCurve[Int(g)], 0), 255))
            bitmap[i * 4 + 2] = UInt8(min(max(CGFloat(r) + rgbCompositeCurve[Int(r)], 0), 255))
            bitmap[i * 4 + 3] = 255
        }
        let bitmapData = Data(bytesNoCopy: bitmap, count: 4 * 256, deallocator: .custom({ ptr, _ in ptr.deallocate() }))
        return CIImage(bitmapData: bitmapData,
                       bytesPerRow: 256 * 4,
                       size: CGSize(width: 256, height: 1),
                       format: .BGRA8,
                       colorSpace: nil)
    }
    
    func getPreparedSplineCurve(points: [CIVector]) -> [CGFloat] {
        assert(points.count > 0)
        
        let convertedPoints = points
            .sorted { $0.x < $1.x } // Sort the array.
            .map({ CIVector(x: $0.x * 255, y: $0.y * 255) }) // Convert from (0, 1) to (0, 255).
        
        var splinePoints = splineCurve(points: convertedPoints)
        
        // If we have a first point like (0.3, 0) we'll be missing some points at the beginning that should be 0.
        if splinePoints.first!.x > 0 {
            var i = splinePoints.first!.x
            while i >= 0 {
                splinePoints.insert(CIVector(x: i, y: 0), at: 0)
                i -= 1
            }
        }
        
        // Insert points similarly at the end, if necessary.
        if splinePoints.last!.x < 255 {
            var i = splinePoints.last!.x + 1
            while i <= 255 {
                splinePoints.append(CIVector(x: i, y: 255))
                i += 1
            }
        }
        
        // Prepare the spline points.
        var preparedSplinePoints = [CGFloat]()
        for i in 0..<splinePoints.count {
            let newPoint = splinePoints[i]
            let oriPoint = CIVector(x: newPoint.x, y: newPoint.x)
            var distance = sqrt(pow(oriPoint.x - newPoint.x, 2.0) + pow(oriPoint.y - newPoint.y, 2.0))
            if oriPoint.y > newPoint.y {
                distance = -distance
            }
            preparedSplinePoints.append(distance)
        }
        return preparedSplinePoints
    }
    
    func splineCurve(points: [CIVector]) -> [CIVector] {
        let sd = secondDerivative(points: points)
        let n = sd.count
        assert(n > 0)
        
        var output = [CIVector]()
        for i in 0..<(n - 1) {
            let cur = points[i]
            let next = points[i + 1]
            
            var x = Int(cur.x)
            while x < Int(next.x) {
                let t = (CGFloat(x) - cur.x) / (next.x - cur.x)
                let a = 1 - t
                let b = t
                let h = next.x - cur.x
                
                var y = a * cur.y + b * next.y + (h * h / 6) * ((a * a * a - a) * CGFloat(sd[i]) + (b * b * b - b) * CGFloat(sd[i + 1]))
                if y > 255 {
                    y = 255
                } else if y < 0 {
                    y = 0
                }
                output.append(CIVector(x: CGFloat(x), y: y))
                
                x += 1
            }
        }
        // The above always misses the last point because the last point is the last next, so we approach but don't equal it.
        output.append(points.last!)
        return output
    }
    
    func secondDerivative(points: [CIVector]) -> [Double] {
        let n = points.count
        assert(n > 1)
        
        var matrix = Array<Array<Double>>(repeating: Array<Double>(repeating: 0, count: 3), count: n) // n x 3
        var result = Array<Double>(repeating: 0, count: n) // n
        matrix[0][1] = 1
        // What about matrix[0][0] and matrix[0][2]? Assuming 0 for now (Brad L.)
        matrix[0][0] = 0
        matrix[0][2] = 0
        
        for i in 1..<(n - 1) {
            let p1 = points[i - 1]
            let p2 = points[i]
            let p3 = points[i + 1]
            
            matrix[i][0] = Double((p2.x - p1.x) / 6)
            matrix[i][1] = Double((p3.x - p1.x) / 3)
            matrix[i][2] = Double((p3.x - p2.x) / 6)
            result[i] = Double((p3.y - p2.y) / (p3.x - p2.x) - (p2.y - p1.y) / (p2.x - p1.x))
        }
        
        // What about result[0] and result[n-1]? Assuming 0 for now (Brad L.)
        result[0] = 0
        result[n - 1] = 0
        
        matrix[n - 1][1] = 1
        // What about matrix[n-1][0] and matrix[n-1][2]? For now, assuming they are 0 (Brad L.)
        matrix[n - 1][0] = 0
        matrix[n - 1][2] = 0
        
        // solving pass1 (up->down)
        for i in 1..<n {
            let k = matrix[i][0] / matrix[i - 1][1]
            matrix[i][1] -= k * matrix[i - 1][2]
            matrix[i][0] = 0
            result[i] -= k * result[i - 1]
        }
        
        // solving pass2 (down->up)
        for i in (0...(n - 2)).reversed() {
            let k = matrix[i][2] / matrix[i + 1][1]
            matrix[i][1] -= k * matrix[i + 1][0]
            matrix[i][2] = 0
            result[i] -= k * result[i + 1]
        }
        
        var output = [Double]()
        for i in 0..<n {
            output.append(result[i] / matrix[i][1])
        }
        return output
    }
}
