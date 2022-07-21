//
//  View.swift
//  
//
//  Created by Benjamin Ridler on 7/6/2023.
//

import SwiftUI

public extension View {
    
    /// Applies both `onAppear` & `onChange` modifiers to the View
    func onAppearOrChange<V: Equatable>(of value: V, perform action: @escaping (V) -> Void) -> some View {
        onAppear{ action(value) }
            .onChange(of: value, perform: action)
    }
}

