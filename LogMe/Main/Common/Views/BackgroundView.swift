//
//  LoginBackgroundView.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//


import SwiftUI

struct BackgroundView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    var enableAnimation: Bool = true

    @State private var circleOffset: CGFloat = -200
    @State private var rectangleRotation: Double = 25
    @State private var ellipseOffset: CGFloat = 220

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple, .blue, .cyan]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(.white.opacity(0.15))
                .frame(width: 300, height: 300)
                .blur(radius: 40)
                .offset(x: -120, y: circleOffset)
                .animation(reduceMotion ? nil : .easeInOut(duration: 10).repeatForever(autoreverses: true), value: circleOffset)

            RoundedRectangle(cornerRadius: 80)
                .fill(.pink.opacity(0.12))
                .frame(width: 250, height: 180)
                .rotationEffect(.degrees(rectangleRotation))
                .blur(radius: 30)
                .offset(x: 100, y: -100)
                .animation(reduceMotion ? nil : .easeInOut(duration: 12).repeatForever(autoreverses: true), value: rectangleRotation)

            Ellipse()
                .fill(.yellow.opacity(0.10))
                .frame(width: 220, height: 120)
                .blur(radius: 25)
                .offset(x: 80, y: ellipseOffset)
                .animation(reduceMotion ? nil : .easeInOut(duration: 14).repeatForever(autoreverses: true), value: ellipseOffset)
            
            Color.black.opacity(0.5).ignoresSafeArea()
        }
        .accessibilityHidden(true)
        .onAppear {
            guard !reduceMotion, enableAnimation else { return }

            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                circleOffset = 50
            }
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                rectangleRotation = 200
            }
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                ellipseOffset = 0
            }
        }
    }
}

#Preview {
    BackgroundView()
}
