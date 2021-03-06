//
//  ButtonModifiers.swift
//  Youtube
//
//  Created by ozan honamlioglu on 9.05.2021.
//

import Foundation
import SwiftUI

struct SurroundWithCircle: ViewModifier {
    var circleSize: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .frame(width: circleSize, height: circleSize, alignment: .center)
                .foregroundColor(.gray)
            
            content
        }
    }
}

struct StateableButton<Content>: ButtonStyle where Content: View {
    var change: (Bool) -> Content
    
    func makeBody(configuration: Configuration) -> some View {
        return change(configuration.isPressed)
    }
    
}

extension View {
    func surroundWithCircle(circleSize: CGFloat) -> some View {
        modifier(SurroundWithCircle(circleSize: circleSize))
    }
}
