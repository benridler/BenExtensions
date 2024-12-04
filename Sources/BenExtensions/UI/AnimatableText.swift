//
//  AnimatableText.swift
//  
//
//  Created by Benjamin Ridler on 21/7/2022.
//

import SwiftUI

/// A Text View that allows an animation to be applied to the view, which will animate that value changing
///
///
/// ```swift
/// @State private var height = 178
///
/// AnimatableText(value: height)
///     .animation(.linear, value: height)
/// ```
public struct AnimatableText: View, @preconcurrency Animatable {
    private var value: Double
    private let format: String
    
    /// Initialises a `AnimatableText` from the `Double` value in the string format provides
    /// - Parameters:
    ///   - value: The value to display and animate the changing of
    ///   - format: The format to display the value in
    public init(value: Double, format: String) {
        self.value = value
        self.format = format
    }
    
    /// Initialises a `AnimatableText` from the `Int` value
    /// - Parameters:
    ///   - value: The value to display and animate the changing of
    public init(value: Int) {
        self.value = Double(value)
        self.format = "%.0f"
    }
    
    public var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    
    public var body: some View {
        Text(String(format: format, value))
    }
}

struct AnimatableText_Previews: PreviewProvider {
    static var previews: some View {
        let value = 10
        AnimatableText(value: value)
            .animation(.linear, value: value)
    }
}
