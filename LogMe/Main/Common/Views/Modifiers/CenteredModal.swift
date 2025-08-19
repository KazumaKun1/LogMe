
import SwiftUI

struct CenteredModal<ModalContent: View>: ViewModifier {
    @AccessibilityFocusState private var isModalFocused: Bool
    @Binding var isPresented: Bool
    let modalContent: () -> ModalContent

    func body(content: Content) -> some View {
        ZStack {
            content
                .accessibilityHidden(isPresented)
            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }
                VStack {
                    modalContent()
                        .frame(maxWidth: 400, maxHeight: 500)
                        .background(.thinMaterial)
                        .cornerRadius(24)
                        .shadow(radius: 20)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    isPresented = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .accessibilityLabel("Close modal")
                                }
                                .padding()
                            }, alignment: .topTrailing
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .bottom))
                .zIndex(1)
                .accessibilityAddTraits(.isModal)
                .accessibilityElement(children: .contain)
                .accessibilityFocused($isModalFocused)
                .onAppear {
                    isModalFocused = true
                }
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}

extension View {
    func centeredModal<ModalContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> ModalContent) -> some View {
        self.modifier(CenteredModal(isPresented: isPresented, modalContent: content))
    }
}
