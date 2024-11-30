import SwiftUI

struct ExpandedCityView: View {
    var city: City
    var namespace: Namespace.ID
    var onTap: () -> Void
    
    @State private var isFullScreen: Bool = false
    @State private var dragOffset: CGSize = .zero
    
    // Animation states
    @State private var imageOffset: CGSize = .zero
    @State private var hasAnimationStarted = false
    @State private var animationDirection: AnimationDirection? = nil
    
    @State private var fullScreenImageOffset: CGSize = .zero
    @State private var hasFullScreenAnimationStarted = false
    @State private var fullScreenAnimationDirection: AnimationDirection? = nil
    
    // Weather states
    @State private var weatherData: WeatherData?
    @State private var isLoadingWeather: Bool = false
    @State private var weatherError: Error?
    
    enum AnimationDirection {
        case leftToRight, rightToLeft, topToBottom, bottomToTop
    }
    
    // MARK: - Computed Properties for Dimensions
    
    private var imageWidth: CGFloat {
        UIScreen.main.bounds.width - 40
    }
    
    private var imageHeight: CGFloat {
        UIScreen.main.bounds.height / 2
    }
    
    private let scaleFactor: CGFloat = 1.2
    private var extraWidth: CGFloat {
        imageWidth * (scaleFactor - 1)
    }
    private var extraHeight: CGFloat {
        imageHeight * (scaleFactor - 1)
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    private let fullScreenScaleFactor: CGFloat = 1.2 // Adjust as needed
    private var fullScreenExtraWidth: CGFloat {
        screenWidth * (fullScreenScaleFactor - 1)
    }
    private var fullScreenExtraHeight: CGFloat {
        screenHeight * (fullScreenScaleFactor - 1)
    }
    
    var body: some View {
        ZStack {
            if isFullScreen {
                fullScreenView()
            } else {
                regularView()
            }
        }
    }
    
    // MARK: - Full Screen View
    
    @ViewBuilder
    private func fullScreenView() -> some View {
        ZStack {
            Image(city.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: city.id, in: namespace)
                .ignoresSafeArea()
                .blur(radius: 7)
                .overlay(Color.black.opacity(0.6))
                .onAppear {
                    startFullScreenImageAnimation()
                    fetchWeather()
                }
                .onDisappear {
                    resetFullScreenAnimation()
                }
            
            VStack(alignment: .center, spacing: 20) {
                cityNameText(fontSize: 60)
                    .padding(.top, 50)
                
                if isLoadingWeather {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else if let weather = weatherData {
                    WeatherView(weatherData: weather)
                } else if weatherError != nil {
                    Text("Failed to load weather data.")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: UIScreen.main.bounds.width - 40)
        }
        .gesture(fullScreenDragGesture())
    }
    
    // MARK: - Regular View
    
    @ViewBuilder
    private func regularView() -> some View {
        VStack {
            Spacer()
            ZStack(alignment: .topLeading) {
                // City Image
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
                        startImageAnimation()
                    }
                
                // City Name
                cityNameText(fontSize: 40)
                    .padding([.top], 20)
                    .padding([.leading, .trailing], 23)
            }
            .onTapGesture(count: 2) {
                enterFullScreen()
            }
            Spacer()
        }
    }
    
    // MARK: - Subviews and Components
    
    private func cityNameText(fontSize: CGFloat) -> some View {
        Text(city.name)
            .font(.custom("GeneralSans-Medium", size: fontSize))
            .foregroundColor(.white)
            .padding(8)
            .cornerRadius(10)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .multilineTextAlignment(.center)
            .accessibilityLabel("City name: \(city.name)")
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private struct WeatherView: View {
        let weatherData: WeatherData
        
        var body: some View {
            VStack(spacing: 10) {
                Text("\(Int(weatherData.main.temp - 273.15))°C")
                    .font(.custom("GeneralSans-Bold", size: 48))
                    .foregroundColor(.white)
                
                Text(weatherData.weather.first?.description.capitalized ?? "")
                    .font(.custom("GeneralSans-Regular", size: 24))
                    .foregroundColor(.white)
            }
        }
    }
    
    // MARK: - Animations and Gestures
    
    private func startImageAnimation() {
        guard !hasAnimationStarted else { return }
        hasAnimationStarted = true
        startAnimation(
            extraWidth: extraWidth,
            extraHeight: extraHeight,
            imageOffset: $imageOffset,
            animationDirection: $animationDirection,
            duration: 8
        )
    }
    
    private func startFullScreenImageAnimation() {
        guard !hasFullScreenAnimationStarted else { return }
        hasFullScreenAnimationStarted = true
        startAnimation(
            extraWidth: fullScreenExtraWidth,
            extraHeight: fullScreenExtraHeight,
            imageOffset: $fullScreenImageOffset,
            animationDirection: $fullScreenAnimationDirection,
            duration: 10
        )
    }
    
    private func startAnimation(
        extraWidth: CGFloat,
        extraHeight: CGFloat,
        imageOffset: Binding<CGSize>,
        animationDirection: Binding<AnimationDirection?>,
        duration: Double
    ) {
        let directions: [AnimationDirection] = [.leftToRight, .rightToLeft, .topToBottom, .bottomToTop]
        animationDirection.wrappedValue = directions.randomElement() ?? .leftToRight
        
        // Set initial offset based on direction
        imageOffset.wrappedValue = initialOffset(for: animationDirection.wrappedValue, extraWidth: extraWidth, extraHeight: extraHeight)
        
        withAnimation(Animation.linear(duration: duration)) {
            imageOffset.wrappedValue = finalOffset(for: animationDirection.wrappedValue, extraWidth: extraWidth, extraHeight: extraHeight)
        }
    }
    
    private func initialOffset(for direction: AnimationDirection?, extraWidth: CGFloat, extraHeight: CGFloat) -> CGSize {
        switch direction {
        case .leftToRight:
            return CGSize(width: -extraWidth / 2, height: 0)
        case .rightToLeft:
            return CGSize(width: extraWidth / 2, height: 0)
        case .topToBottom:
            return CGSize(width: 0, height: -extraHeight / 2)
        case .bottomToTop:
            return CGSize(width: 0, height: extraHeight / 2)
        default:
            return .zero
        }
    }
    
    private func finalOffset(for direction: AnimationDirection?, extraWidth: CGFloat, extraHeight: CGFloat) -> CGSize {
        switch direction {
        case .leftToRight:
            return CGSize(width: extraWidth / 2, height: 0)
        case .rightToLeft:
            return CGSize(width: -extraWidth / 2, height: 0)
        case .topToBottom:
            return CGSize(width: 0, height: extraHeight / 2)
        case .bottomToTop:
            return CGSize(width: 0, height: -extraHeight / 2)
        default:
            return .zero
        }
    }
    
    private func resetFullScreenAnimation() {
        hasFullScreenAnimationStarted = false
        fullScreenImageOffset = .zero
    }
    
    private func enterFullScreen() {
        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
        impactHeavy.impactOccurred()
        withAnimation(.easeInOut(duration: 0.5)) {
            isFullScreen = true
        }
    }
    
    private func fullScreenDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset.width = value.translation.width
            }
            .onEnded { _ in
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
    }
    
    // MARK: - Weather Fetching
    
    private func fetchWeather() {
        isLoadingWeather = true
        weatherError = nil
        let weatherService = WeatherService()
        weatherService.fetchWeather(for: city.name) { result in
            DispatchQueue.main.async {
                isLoadingWeather = false
                switch result {
                case .success(let data):
                    self.weatherData = data
                case .failure(let error):
                    self.weatherError = error
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
            namespace: namespace,
            onTap: {}
        )
    }
}
