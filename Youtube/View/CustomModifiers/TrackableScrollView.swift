//
//  TrackableScrollView.swift
//  Youtube
//
//  Created by ozan honamlioglu on 14.05.2021.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct TrackableScrollView: ViewModifier {

    func body(content: Content) -> some View {
        return ScrollView {
            GeometryReader { geo in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geo.frame(in: .named("scrollView")).origin
                )
            }.frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: "scrollView")
    }
}
