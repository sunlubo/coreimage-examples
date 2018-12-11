//
//  Util.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Cocoa
import simd
import PlaygroundSupport

extension float3: CustomPlaygroundDisplayConvertible {

    public var playgroundDescription: Any {
        return NSColor(red: CGFloat(self[0]), green: CGFloat(self[1]), blue: CGFloat(self[2]), alpha: 1.0)
    }
}
