//
//  ExpandedCityView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-26.
//

import SwiftUI

struct ExpandedCityView: View {
    var city: City
    var namespace: Namespace.ID
    var onTap: () -> Void
    
    @State private var isFullScreen: Bool = false
    @State private var dragOffset: CGSize = .zero
    
    @State private var imageOffset: CGSize = .zero
    @State private var hasAnimationStarted = false
    @State private var animationDirection: AnimationDirection? = nil
    
    @State private var fullScreenImageOffset: CGSize = .zero
    @State private var hasFullScreenAnimationStarted = false
    @State private var fullScreenAnimationDirection: AnimationDirection? = nil
    
    enum AnimationDirection {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
    }
    
    var body: some View {
        
        let imageWidth = UIScreen.main.bounds.width - 40
        let imageHeight = UIScreen.main.bounds.height / 2
        let scaleFactor: CGFloat = 1.2
        let extraWidth = imageWidth * (scaleFactor - 1)
        let extraHeight = imageHeight * (scaleFactor - 1)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let fullScreenScaleFactor: CGFloat = 1.2 // Adjust as needed
        let fullScreenExtraWidth = screenWidth * (fullScreenScaleFactor - 1)
        let fullScreenExtraHeight = screenHeight * (fullScreenScaleFactor - 1)
        
        ZStack {
            if isFullScreen {
                Image(city.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: city.id, in: namespace)
                    .ignoresSafeArea()
                    .blur(radius: 7)
                    .overlay(Color.black.opacity(0.6))
                    .onAppear() {
                        startFullScreenImageAnimation(
                            extraWidth: fullScreenExtraWidth,
                            extraHeight: fullScreenExtraHeight)
                    }
                    .offset(x: dragOffset.width)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset.width = value.translation.width
                            }
                            .onEnded { value in
                                let dragThreshold: CGFloat = 100
                                
                                if abs(dragOffset.width) > dragThreshold {
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isFullScreen = false
                                        dragOffset = .zero
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        dragOffset = .zero
                                    }
                                }
                                
                            }
                    )
                
            } else {
                VStack {
                    Spacer()
                    ZStack(alignment: .topLeading) {
                        Image(city.imageName)
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: city.id, in: namespace)
                            .frame(width: imageWidth, height: imageHeight)
                            .scaleEffect(scaleFactor)
                            .offset(imageOffset)
                            .clipped()
                            .cornerRadius(25)
                            .shadow(radius: 10)
                            .onAppear {
                                startImageAnimation(extraWidth: extraWidth, extraHeight: extraHeight)
                            }
                        
                            Text(city.name)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(10)
                                .padding([.top], 20)
                                .padding([.leading, .trailing], 23)
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)
                                .multilineTextAlignment(.center)
                                .accessibilityLabel("City name: \(city.name)")


                    }
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
    
    func startImageAnimation(extraWidth: CGFloat, extraHeight: CGFloat) {
           // Only start the animation once
           if !hasAnimationStarted {
               hasAnimationStarted = true
               // Generate a random direction
               let directions: [AnimationDirection] = [.leftToRight, .rightToLeft, .topToBottom, .bottomToTop]
               animationDirection = directions.randomElement() ?? .leftToRight

               // Set initial offset based on direction
               switch animationDirection {
               case .leftToRight:
                   imageOffset = CGSize(width: -extraWidth / 2, height: 0)
               case .rightToLeft:
                   imageOffset = CGSize(width: extraWidth / 2, height: 0)
               case .topToBottom:
                   imageOffset = CGSize(width: 0, height: -extraHeight / 2)
               case .bottomToTop:
                   imageOffset = CGSize(width: 0, height: extraHeight / 2)
               case .none:
                   imageOffset = .zero
               }

               withAnimation(Animation.linear(duration:  8)) {
                   switch animationDirection {
                   case .leftToRight:
                       imageOffset = CGSize(width: extraWidth / 2, height: 0)
                   case .rightToLeft:
                       imageOffset = CGSize(width: -extraWidth / 2, height: 0)
                   case .topToBottom:
                       imageOffset = CGSize(width: 0, height: extraHeight / 2)
                   case .bottomToTop:
                       imageOffset = CGSize(width: 0, height: -extraHeight / 2)
                   case .none:
                       imageOffset = .zero
                   }
               }
           }
       }
    
    func startFullScreenImageAnimation(extraWidth: CGFloat, extraHeight: CGFloat) {
        if !hasFullScreenAnimationStarted {
            hasFullScreenAnimationStarted = true

            let directions: [AnimationDirection] = [.leftToRight, .rightToLeft, .topToBottom, .bottomToTop]
            fullScreenAnimationDirection = directions.randomElement() ?? .leftToRight

            switch fullScreenAnimationDirection {
            case .leftToRight:
                fullScreenImageOffset = CGSize(width: -extraWidth / 2, height: 0)
            case .rightToLeft:
                fullScreenImageOffset = CGSize(width: extraWidth / 2, height: 0)
            case .topToBottom:
                fullScreenImageOffset = CGSize(width: 0, height: -extraHeight / 2)
            case .bottomToTop:
                fullScreenImageOffset = CGSize(width: 0, height: extraHeight / 2)
            case .none:
                fullScreenImageOffset = .zero
            }

            withAnimation(Animation.linear(duration: 10)) {
                switch fullScreenAnimationDirection {
                case .leftToRight:
                    fullScreenImageOffset = CGSize(width: extraWidth / 2, height: 0)
                case .rightToLeft:
                    fullScreenImageOffset = CGSize(width: -extraWidth / 2, height: 0)
                case .topToBottom:
                    fullScreenImageOffset = CGSize(width: 0, height: extraHeight / 2)
                case .bottomToTop:
                    fullScreenImageOffset = CGSize(width: 0, height: -extraHeight / 2)
                case .none:
                    fullScreenImageOffset = .zero
                }
            }
        }
    }
}

struct ExpandedCityView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ExpandedCityView(
            city: City(id: 1, name: "Buenos Aires, Argentina", imageName: "Argentina"),
            //city: City(id: 1, name: "Argentina", imageName: "Argentina"),
            namespace: namespace,
            onTap: {}
        )
    }
}
