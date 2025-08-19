//
//  LoadingView.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotationAngle: Double = -15
    @State private var isAnimating = false
    @State private var trimEnd = 0.2
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea(.all)
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: trimEnd)
                        .stroke(
                            Color.gray.opacity(0.8),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .frame(width: 75, height: 75)
                        .rotationEffect(
                            Angle(degrees: isAnimating ? 360 : 0)
                        )
                        .animation(
                            .linear(duration: 1.5)
                            .repeatForever(autoreverses: false),
                            value: isAnimating)
                        .accessibilityHidden(true)
                }
            }
            .padding(30)
            .background(.thinMaterial)
            .cornerRadius(10)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading")
        .onAppear {
            isAnimating = true
            withAnimation(
                .linear(duration: 2)
                .repeatForever(autoreverses: true)) {
                    trimEnd = 0.9
            }
        }
    }
}

#Preview {
    LoadingView()
}
