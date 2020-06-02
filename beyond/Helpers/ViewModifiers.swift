//
//  ViewModifiers.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import SwiftUI

struct FlippedUpsideDown: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: 180))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}
