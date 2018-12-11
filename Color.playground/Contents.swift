//
//  Color.playground
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Cocoa
import simd

// RGB
let black   = float3(0.0, 0.0, 0.0)
let white   = float3(1.0, 1.0, 1.0)
let gray    = float3(0.5, 0.5, 0.5)
let red     = float3(1.0, 0.0, 0.0)
let green   = float3(0.0, 1.0, 0.0)
let blue    = float3(0.0, 0.0, 1.0)
let yellow  = float3(1.0, 1.0, 0.0)
let magenta = float3(1.0, 0.0, 1.0)
let cyan    = float3(0.0, 1.0, 1.0)

// https://color-wheel-artist.com/hue/
mix(red, white, t: 0.5) // Tint
mix(red, gray,  t: 0.5) // Tone
mix(red, black, t: 0.5) // Shade

// HSV
NSColor(hue:   0 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 0
NSColor(hue:  60 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 60
NSColor(hue: 120 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 120
NSColor(hue: 180 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 180
NSColor(hue: 240 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 240
NSColor(hue: 300 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 300
NSColor(hue: 360 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 360

// RGB <=> HSV
rgb2hsv(color: float3(1.0, 0.0, 0.0))
rgb2hsv(color: float3(0.5, 1.0, 0.5))
rgb2hsv(color: float3(0.0, 0.0, 0.5))
hsv2rgb(color: rgb2hsv(color: float3(1.0, 0.0, 0.0)))
hsv2rgb(color: rgb2hsv(color: float3(0.5, 1.0, 0.5)))
hsv2rgb(color: rgb2hsv(color: float3(0.0, 0.0, 0.5)))

// RGB <=> HSL
rgb2hsl(color: float3(1.0, 0.0, 0.0))
rgb2hsl(color: float3(0.5, 1.0, 0.5))
rgb2hsl(color: float3(0.0, 0.0, 0.5))
hsl2rgb(color: rgb2hsl(color: float3(1.0, 0.0, 0.0)))
hsl2rgb(color: rgb2hsl(color: float3(0.5, 1.0, 0.5)))
hsl2rgb(color: rgb2hsl(color: float3(0.0, 0.0, 0.5)))

// RGB <=> YUV
rgb2yuv(color: float3(1.0, 0.0, 0.0))
rgb2yuv(color: float3(0.5, 1.0, 0.5))
rgb2yuv(color: float3(0.0, 0.0, 0.5))
yuv2rgb(color: rgb2yuv(color: float3(1.0, 0.0, 0.0)))
yuv2rgb(color: rgb2yuv(color: float3(0.5, 1.0, 0.5)))
yuv2rgb(color: rgb2yuv(color: float3(0.0, 0.0, 0.5)))

// RGB <=> YIQ
rgb2yiq(color: float3(1.0, 0.0, 0.0))
rgb2yiq(color: float3(0.5, 1.0, 0.5))
rgb2yiq(color: float3(0.0, 0.0, 0.5))
yiq2rgb(color: rgb2yiq(color: float3(1.0, 0.0, 0.0)))
yiq2rgb(color: rgb2yiq(color: float3(0.5, 1.0, 0.5)))
yiq2rgb(color: rgb2yiq(color: float3(0.0, 0.0, 0.5)))

// RGB <=> YCbCr
rgb2ycbcr(color: float3(1.0, 0.0, 0.0))
rgb2ycbcr(color: float3(0.5, 1.0, 0.5))
rgb2ycbcr(color: float3(0.0, 0.0, 0.5))
ycbcr2rgb(color: rgb2ycbcr(color: float3(1.0, 0.0, 0.0)))
ycbcr2rgb(color: rgb2ycbcr(color: float3(0.5, 1.0, 0.5)))
ycbcr2rgb(color: rgb2ycbcr(color: float3(0.0, 0.0, 0.5)))
