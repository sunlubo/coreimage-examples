//
//  MetalContext.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import Metal

public final class MetalContext {
    public static let shared = MetalContext()
    
    public let device: MTLDevice
    public let commandQueue: MTLCommandQueue
    
    public init() {
        self.device = MTLCreateSystemDefaultDevice()!
        self.commandQueue = device.makeCommandQueue()!
    }
    
    public func makeRenderPipelineState(descriptor: MTLRenderPipelineDescriptor) -> MTLRenderPipelineState {
        do {
            return try device.makeRenderPipelineState(descriptor: descriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func makeComputePipelineState(function: MTLFunction) -> MTLComputePipelineState {
        do {
            return try device.makeComputePipelineState(function: function)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func makeCommandBuffer() -> MTLCommandBuffer {
        return commandQueue.makeCommandBuffer()!
    }
    
    public func makeTexture(descriptor: MTLTextureDescriptor) -> MTLTexture {
        return device.makeTexture(descriptor: descriptor)!
    }
}
