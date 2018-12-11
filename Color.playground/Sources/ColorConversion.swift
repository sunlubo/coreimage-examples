//
//  ColorConversion.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import simd

// https://zh.wikipedia.org/wiki/HSL%E5%92%8CHSV%E8%89%B2%E5%BD%A9%E7%A9%BA%E9%97%B4

/// RGB -> HSV
public func rgb2hsv(color: float3) -> float3 {
    let r = color[0]
    let g = color[1]
    let b = color[2]
    let min = color.min()!
    let max = color.max()!
    
    var h = 0 as Float
    var s = 0 as Float
    var v = 0 as Float
    var degree = 0 as Float
    
    // H
    if max == min {
        degree = 0
    } else if max == r && g >= b {
        degree = 60 * (g - b) / (max - min) + 0
    } else if max == r && g < b {
        degree = 60 * (g - b) / (max - min) + 360
    } else if max == g {
        degree = 60 * (b - r) / (max - min) + 120
    } else if max == b {
        degree = 60 * (r - g) / (max - min) + 240
    }
    h = degree / 360
    // S
    if max == 0 {
        s = 0
    } else {
        s = 1 - min / max
    }
    // V
    v = max
    
    return float3(h, s, v)
}

/// HSV -> RGB
public func hsv2rgb(color: float3) -> float3 {
    let h = color[0] * 360
    let s = color[1]
    let v = color[2]
    let hi = Int(floor(h / 60)) % 6
    let f = h / 60 - Float(hi)
    let p = v * (1 - s)
    let q = v * (1 - f * s)
    let t = v * (1 - (1 - f) * s)
    
    var r = 0 as Float
    var g = 0 as Float
    var b = 0 as Float
    
    switch hi {
    case 0:
        r = v
        g = t
        b = p
    case 1:
        r = q
        g = v
        b = p
    case 2:
        r = p
        g = v
        b = t
    case 3:
        r = p
        g = q
        b = v
    case 4:
        r = t
        g = p
        b = v
    case 5:
        r = v
        g = p
        b = q
    default:
        fatalError("unreachable")
    }
    
    return float3(r, g, b)
}

/// RGB -> HSL
public func rgb2hsl(color: float3) -> float3 {
    let r = color[0]
    let g = color[1]
    let b = color[2]
    let min = color.min()!
    let max = color.max()!
    
    var h = 0 as Float
    var s = 0 as Float
    var l = 0 as Float
    var degree = 0 as Float
    
    // H
    if max == min {
        degree = 0
    } else if max == r && g >= b {
        degree = 60 * (g - b) / (max - min) + 0
    } else if max == r && g < b {
        degree = 60 * (g - b) / (max - min) + 360
    } else if max == g {
        degree = 60 * (b - r) / (max - min) + 120
    } else if max == b {
        degree = 60 * (r - g) / (max - min) + 240
    }
    h = degree / 360
    // L
    l = (min + max) / 2
    // S
    if l == 0 || min == max {
        s = 0
    } else if l > 0 && l <= 0.5 {
        s = (max - min) / (2 * l)
    } else if l > 0.5 {
        s = (max - min) / (2 - 2 * l)
    }
    
    return float3(h, s, l)
}

/// HSL -> RGB
public func hsl2rgb(color: float3) -> float3 {
    let h = color[0]
    let s = color[1]
    let l = color[2]
    
    if s == 0 {
        return float3(l, l, l)
    }
    
    let q = l < 0.5 ? (l * (1 + s)) : (l + s - (l * s))
    let p = 2 * l - q
    let tr = h + 1 / 3
    let tg = h
    let tb = h - 1 / 3
    let tcs = [tr, tg, tb]
    
    var rgb = float3(0, 0, 0)
    for i in 0..<tcs.count {
        var tc = tcs[i]
        if tc < 0 {
            tc = tc + 1
        } else if tc > 1 {
            tc = tc - 1
        }
        
        if tc < 1 / 6 {
            rgb[i] = p + (q - p) * 6 * tc
        } else if tc >= 1 / 6 && tc < 1 / 2 {
            rgb[i] = q
        } else if tc >= 1 / 2 && tc < 2 / 3 {
            rgb[i] = p + (q - p) * 6 * (2 / 3 - tc)
        } else {
            rgb[i] = p
        }
    }
    
    return rgb
}

// https://en.wikipedia.org/wiki/YUV

/// RGB -> YUV
public func rgb2yuv(color: float3) -> float3 {
    let m = float3x3(rows: [
        float3( 0.299,  0.587,  0.114),
        float3(-0.147, -0.289,  0.436),
        float3( 0.615, -0.515, -0.100)
    ])
    return m * color
}

/// YUV -> RGB
public func yuv2rgb(color: float3) -> float3 {
    let m = float3x3(rows: [
        float3(1.000,  0.000,  1.140),
        float3(1.000, -0.395, -0.581),
        float3(1.000,  2.032,  0.000)
    ])
    return m * color
}

/// RGB -> YIQ
public func rgb2yiq(color: float3) -> float3 {
    let m = float3x3(rows: [
        float3(0.299,  0.587,  0.114),
        float3(0.596, -0.274, -0.322),
        float3(0.212, -0.523,  0.311)
    ])
    return m * color
}

/// YIQ -> RGB
public func yiq2rgb(color: float3) -> float3 {
    let m = float3x3(rows: [
        float3(1.000,  0.956,  0.621),
        float3(1.000, -0.272, -0.647),
        float3(1.000, -1.105,  1.702)
    ])
    return clamp(m * color, min: 0, max: 1)
}

/// RGB -> YCbCr
public func rgb2ycbcr(color: float3) -> float3 {
    let m = float3x3(rows: [
        float3( 0.299,  0.587,  0.114),
        float3(-0.169, -0.331,  0.500),
        float3( 0.500, -0.419, -0.081)
    ])
    return m * color
}

/// YCbCr -> RGB
public func ycbcr2rgb(color: float3) -> float3 {
    let m = float3x3(rows: [
        float3(1.000,  0.000,  1.403),
        float3(1.000, -0.344, -0.714),
        float3(1.000,  1.773,  0.000)
    ])
    return clamp(m * color, min: 0, max: 1)
}
