//
//  SwiftUIView.swift
//  Glacid
//
//  Created by Eric on 21/04/25.
//

import CoreMotion
import SwiftUI

/// A view modifier that applies a glacial, frosted glass effect to shapes.
///
/// The `GlacidView` modifier creates a sophisticated glass-like appearance by combining
/// multiple visual effects:
/// - A translucent material backdrop
/// - A subtle gradient border that follows device orientation
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
    let motionManager = CMMotionManager()
    @State private var roll: Double = 0.0

    /// Creates a view that applies a glacial effect to the specified shape.
    ///
    /// - Parameter shape: A `Shape` to which the effect will be applied.
    public init(shape: S) {
        self.shape = shape
    }

    private var gradientStartPoint: UnitPoint {
        let adjustedRoll = roll * 2.0
        return UnitPoint(x: 0.5 + cos(adjustedRoll), y: 0.5 + sin(adjustedRoll))
    }

    private var gradientEndPoint: UnitPoint {
        let adjustedRoll = roll * 2.0
        return UnitPoint(x: 0.5 - cos(adjustedRoll), y: 0.5 - sin(adjustedRoll))
    }

    public var body: some View {
        Group {
            if shape is Circle {
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
                                            color: Color(
                                                .tertiarySystemBackground),
                                            location: 0.5),
                                        Gradient.Stop(
                                            color: Color(.quaternaryLabel),
                                            location: 0.85),
                                        Gradient.Stop(
                                            color: Color(.quaternaryLabel),
                                            location: 1.0),
                                    ],
                                    startPoint: gradientStartPoint,
                                    endPoint: gradientEndPoint
                                ),
                                lineWidth: 2
                            )
                    )
                    .shadow(
                        color: Color(.quaternarySystemFill).opacity(0.5),
                        radius: 2, x: 0, y: 1)
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
                                            color: Color(.quaternaryLabel)
                                                .opacity(0.8),
                                            location: 0.1),
                                        Gradient.Stop(
                                            color: Color(
                                                .tertiarySystemBackground),
                                            location: 0.5),
                                        Gradient.Stop(
                                            color: Color(.quaternaryLabel)
                                                .opacity(0.8),
                                            location: 0.85),
                                        Gradient.Stop(
                                            color: Color(.quaternaryLabel)
                                                .opacity(0.8),
                                            location: 1.0),
                                    ],

                                    startPoint: gradientStartPoint,
                                    endPoint: gradientEndPoint
                                ),
                                lineWidth: 2
                            )
                    )
                    .shadow(
                        color: Color(.quaternarySystemFill).opacity(0.5),
                        radius: 2, x: 0, y: 1)
            }
        }
        .onAppear {
            startMotionUpdates()
        }
        .onDisappear {
            stopMotionUpdates()
        }
    }

    /// Starts receiving device motion updates at 60Hz and animates the roll value.
    ///
    /// - Note: Only works if device motion is available.
    private func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1 / 60
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion else { return }
            withAnimation(.linear(duration: 0.1)) {
                self.roll = motion.attitude.roll
            }
        }
    }

    /// Stops device motion updates to conserve resources.
    private func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
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
