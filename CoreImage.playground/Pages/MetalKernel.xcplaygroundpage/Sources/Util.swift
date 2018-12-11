//
//  Util.swift
//
//  Copyright © 2018 sunlubo. All rights reserved.
//

import Foundation
import CoreImage

extension CIKernel {

    public convenience init(functionName: String) {
        let metallibURL = Bundle.main.url(forResource: "Filters", withExtension: "metallib")!
        let metallib = try! Data(contentsOf: metallibURL)
        do {
            try self.init(functionName: functionName, fromMetalLibraryData: metallib)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
