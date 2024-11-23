//
//  ExpandedRectangleView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-23.
//

import SwiftUI

struct ExpandedRectangleView: View {
    var index: Int
    var title: String
    var color: Color
    var namespace: Namespace.ID
    var onTap: () -> Void
    
    @State private var isFullScreen: Bool = false
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        VStack {
            if isFullScreen {
                RoundedRectangle(cornerRadius: 0)
                    .fill(color)
                    .matchedGeometryEffect(id: index, in: namespace)
                    .ignoresSafeArea()
                    .overlay(
                        VStack(spacing: 20) {
                            Text(title)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                            Text("This is full screen view")
                                .font(.title)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                            .padding(.top, 50)
                    )
                    //.offset(x: dragOffset.width)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Update drag offset (allow dragging in both directions)
                                dragOffset.width = value.translation.width
                            }
                            .onEnded { value in
                                let dragThreshold: CGFloat = 100
                                if abs(dragOffset.width) > dragThreshold {
                                    // If dragged enough, exit full-screen mode
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isFullScreen = false
                                        dragOffset = .zero
                                    }
                                } else {
                                    // Otherwise, snap back to original position
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                    )
            } else {
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .fill(color)
                        .matchedGeometryEffect(id: index, in: namespace)
                        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 2)
                        .overlay(
                            VStack {
                                Text(title)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding()
                                
                                Text("Detailed information about \(title) will be displayed here.")
                                    .font(.body)
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        )
                        .onTapGesture(count: 2) {
                            
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                            
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isFullScreen = true
                            }
                        }
                    Spacer()
                }
            }
        }
    }
}

struct ExpandedRectangleView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ExpandedRectangleView(
            index: 0,
            title: "Sample Title",
            color: .blue,
            namespace: namespace
        ) {
            print("Rectangle tapped")
        }
    }
}
