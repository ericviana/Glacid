//
//  SwiftUIView.swift
//  Glacid
//
//  Created by Eric on 21/04/25.
//

import SwiftUI

/// A view modifier that applies a glacial, frosted glass effect to shapes.
///
/// The `GlacidView` modifier creates a sophisticated glass-like appearance by combining
/// multiple visual effects:
/// - A translucent material backdrop
/// - A subtle gradient border
/// - Soft shadows for depth
///
/// You can apply this effect to any shape using the `Shape/glacid()` modifier.
///
/// ## Example
/// ```swift
/// Rectangle()
///     .glacid()
///     .frame(width: 100, height: 100)
/// ```
///
/// You can also use it with buttons and other interactive elements:
/// ```swift
/// Button(action: { }) {
///     Text("Tap me")
///         .background(
///             Capsule()
///                 .glacid()
///                 .frame(width: 200, height: 60)
///         )
/// }
/// ```
public struct GlacidView<S: Shape>: View {
    /// The shape to which the glacial effect will be applied.
    let shape: S

    /// Creates a view that applies a glacial effect to the specified shape.
    ///
    /// - Parameter shape: A `Shape` to which the effect will be applied.
    public init(shape: S) {
        self.shape = shape
    }

    public var body: some View {
        if shape is Circle {
            // Special handling for Circle
            shape
                .background(shape)
                .foregroundStyle(.ultraThinMaterial)
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(
                                        color: Color(.quaternaryLabel),
                                        location: 0.1),
                                    Gradient.Stop(
                                        color: Color(.tertiarySystemBackground),
                                        location: 0.5),
                                    Gradient.Stop(
                                        color: Color(.quaternaryLabel),
                                        location: 0.85),
                                    Gradient.Stop(
                                        color: Color(.quaternaryLabel),
                                        location: 1.0),
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .shadow(
                    color: Color(.quaternarySystemFill).opacity(0.5), radius: 2,
                    x: 0, y: 1)
        } else {
            shape
                .background(shape)
                .foregroundStyle(.ultraThinMaterial)
                .overlay(
                    shape
                        .stroke(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(
                                        color: Color(.quaternaryLabel),
                                        location: 0.0),
                                    Gradient.Stop(
                                        color: Color(.tertiarySystemBackground),
                                        location: 0.15),
                                    Gradient.Stop(
                                        color: Color(.tertiarySystemBackground),
                                        location: 0.85),
                                    Gradient.Stop(
                                        color: Color(.quaternaryLabel),
                                        location: 1.0),
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .shadow(
                    color: Color(.quaternarySystemFill).opacity(0.5), radius: 2,
                    x: 0, y: 1)
        }
    }
}

/// Extension providing convenient access to the glacial effect for shapes.
extension Shape {
    /// Applies a glacial, frosted glass effect to the shape.
    ///
    /// Use this modifier to create a sophisticated glass-like appearance for any shape.
    ///
    /// - Returns: A ``GlacidView`` containing the modified shape.
    public func glacid() -> GlacidView<Self> {
        GlacidView(shape: self)
    }
}

/// Extension providing a no-op glacid modifier for general views.
extension View {
    /// A no-op modifier that maintains API consistency when `glacid()` is called on regular views.
    ///
    /// This modifier does nothing when applied to regular views, but allows for consistent API usage
    /// across your codebase.
    ///
    /// - Returns: The original view without modification.
    public func glacid() -> some View {
        self
    }
}

#Preview {
    /// Preview demonstrating various uses of the Glacid effect
    VStack(spacing: 64) {
        // Basic shapes example
        Rectangle()
            .glacid()
            .frame(width: 100, height: 100)

        RoundedRectangle(cornerRadius: 18)
            .glacid()
            .frame(width: 200, height: 60)

        Ellipse()
            .glacid()
            .frame(width: 200, height: 60)

        // Button with Glacid effect
        Button(
            action: {
                print("Button tapped!")
            },
            label: {
                Text("Tap me")
                    .foregroundStyle(.gray)
                    .background(
                        Capsule()
                            .glacid()
                            .frame(width: 200, height: 60)
                    )
            })

        // SF Symbols with Glacid
        Image(systemName: "heart.fill")
            .font(.title)
            .foregroundStyle(.secondary)
            .background {
                Circle()
                    .glacid()
                    .frame(width: 80, height: 80)
            }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground)).ignoresSafeArea()
}
