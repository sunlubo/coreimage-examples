import Foundation
import CoreML

extension MLModel {
    
    static let modelDir = "file:///Users/sun/Development/GitHub/iOS/iOSMedia/CoreImage.playground/Pages/Stylize.xcplaygroundpage/Resources"
    
    public static func loadModel(named name: String) throws -> MLModel {
        let modelUrl = URL(string: "\(MLModel.modelDir)/\(name).mlmodel")!
        let compileModelUrl = try MLModel.compileModel(at: modelUrl)
        return try MLModel(contentsOf: compileModelUrl)
    }
}
