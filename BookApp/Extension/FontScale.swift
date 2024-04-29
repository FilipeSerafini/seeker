//
//  FontScale.swift
//  Seeker
//
//  Created by Waldyr Schneider on 15/03/24.
//

import Foundation
import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var size: Double
    var weight: Font.Weight

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.system(size: scaledSize, weight: weight))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(size: Double, weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: size, weight: weight))
    }
}
