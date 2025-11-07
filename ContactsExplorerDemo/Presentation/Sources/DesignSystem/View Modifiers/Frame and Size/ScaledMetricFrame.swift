//
//  ScaledMetricFrame.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

fileprivate struct ScaledHeight: ViewModifier {
    @ScaledMetric var height: CGFloat
    var maxHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(height: height > maxHeight ? maxHeight : height)
    }
}

fileprivate struct ScaledWidth: ViewModifier {
    @ScaledMetric var width: CGFloat
    var maxWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width > maxWidth ? maxWidth : width)
    }
}

public extension View {
    
    /// Scaled width by `ScaledMetric`, the provided value is applied at 100%, and scales up to `maxWidth` property as dynamic type value changes.
    ///
    ///  - parameter width: The value used at 100% to be scaled.
    ///  - parameter maxWidth: Limits the width to scale up to this value.
    @ViewBuilder
    func scaledMetricWidth(_ width: CGFloat, maxWidth: CGFloat = .infinity) -> some View {
        modifier(ScaledWidth(width: width, maxWidth: maxWidth))
    }
    
    /// Scaled height by `ScaledMetric`, the provided value is applied at 100%, and scales up to `maxHeight` property as dynamic type value changes.
    ///
    ///  - parameter height: The value used at 100% to be scaled.
    ///  - parameter maxHeight: Limits the height to scale up to this value.
    @ViewBuilder
    func scaledMetricHeight(_ height: CGFloat, maxHeight: CGFloat = .infinity) -> some View {
        modifier(ScaledHeight(height: height, maxHeight: maxHeight))
    }
    
    /// Scaled width and height by `ScaledMetric`, the provided `width` and `height` values are applied at 100%, and scale up to `maxWidth`/`maxWidth` property as dynamic type value changes.
    ///
    ///  - parameter width: The value used at 100% to be scaled.
    ///  - parameter maxWidth: Limits the width to scale up to this value.
    ///  - parameter height: The value used at 100% to be scaled.
    ///  - parameter maxHeight: Limits the height to scale up to this value.
    @ViewBuilder
    func scaledMetricFrame(width: CGFloat, maxWidth: CGFloat = .infinity, height: CGFloat, maxHeight: CGFloat = .infinity) -> some View {
        modifier(ScaledWidth(width: width, maxWidth: maxWidth))
            .modifier(ScaledHeight(height: height, maxHeight: maxHeight))
    }
    
    /// Scaled width and height by `ScaledMetric`, the provided `size` value is applied at 100%, and scales up to `maxSize` property as dynamic type value changes.
    ///
    ///  - parameter size: The value used at 100% to be scaled.
    ///  - parameter maxSiza: Limits the width & height to scale up to this value.
    @ViewBuilder
    func scaledMetricFrame(size: CGFloat, maxSize: CGFloat = .infinity) -> some View {
        scaledMetricFrame(width: size, maxWidth: maxSize, height: size, maxHeight: maxSize)
    }
}
