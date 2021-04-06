import SwiftUI

struct ContentView: View {
    var body: some View {
        LikeButton()
    }
}

struct LikeButton: View {
    @State private var state = AnimationState()
    @State private var resetAnimations = true
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Image("heart")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(state.heartColor)
                    .frame(width: state.heartSize, height: state.heartSize)
                    .position(x: reader.size.width / 2, y: reader.size.height / 2)
                
                Circle()
                    .strokeBorder(state.strokeColor, lineWidth: state.strokeWidth)
                    .background(Circle().foregroundColor(state.shapeColor))
                    .frame(width: state.shapeSize, height: state.shapeSize)
                    .position(x: reader.size.width / 2, y: reader.size.height / 2)
                
                let numberOfMarks: Int = 7
                
                ForEach(0..<numberOfMarks) { index in
                    let rotation = Angle(radians: 2 * .pi / Double(numberOfMarks) * Double(index))
                    ZStack {
                        // particle on the left
                        Circle()
                            .foregroundColor(state.particleColorA)
                            .frame(width: state.particleSize, height: state.particleSize)
                            .offset(x: 3, y: state.particleOffsetA)
                            .rotationEffect(Angle(degrees: -5))
                    }
                    .frame(width: 15, height: 40)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                    .offset(x: 0, y: 40)
                    .rotationEffect(rotation)
                }
                
            }
            .frame(width: reader.size.width, height: reader.size.height)
        }
        .background(Color.white)
        .onTapGesture {
            
            resetAnimations.toggle()
            
            if resetAnimations {
                state = AnimationState()
                return
            }
            
            state.heartColor = Color.gray
            state.heartSize = 0
            
            AnimationSequence()
                .add { anim in
                    anim.easing = .spring
                    anim.duration = 0.05
                    anim.animations {
                        state.shapeSize = 50
                        state.shapeColor = .pink
                        state.strokeWidth = 20
                    }
                }
                .add { anim in
                    anim.easing = .spring
                    anim.duration = 0.05
                    anim.animations {
                        state.strokeColor = state.shapeColor
                        state.shapeColor = .clear
                    }
                }
                .add { anim in
                    anim.easing = .spring
                    anim.duration = 0.005
                    anim.animations {
                        state.strokeWidth = 0
                    }
                }
                .add { anim in
                    anim.duration = 0.1
                    anim.easing = .linear
                    anim.animations {
                        state.heartSize = 55
                        state.heartColor = .pink
                    }
                }
                .add { anim in
                    anim.duration = 0.09
                    anim.easing = .linear
                    anim.animations {
                        state.particleSize = 5
                        state.particleColorA = .pink
                        state.particleColorB = .pink
                        state.particleOffsetA = 0
                        state.particleOffsetB = 5
                    }
                }
                .add { anim in
                    anim.duration = 0.25
                    anim.delay = -0.1
                    anim.easing = .linear
                    anim.animations {
                        state.heartSize = 50
                        state.particleSize = 0
                        state.particleColorA = .white
                        state.particleColorB = .white
                        state.particleOffsetA = 12
                        state.particleOffsetB = 16
                    }
                }
                .start()
        }
    }
}

struct AnimationState {
    var strokeWidth: CGFloat = 10
    var strokeColor: Color = .clear
    var shapeColor = Color(.sRGB, red: 223/255, green: 69/255, blue: 136/255, opacity: 1)
    var shapeSize: CGFloat = 0
    
    var heartSize: CGFloat = 50
    var heartColor: Color = .gray
    
    var particleOffsetA: CGFloat = 0
    var particleOffsetB: CGFloat = -2
    
    var particleColorA: Color = .clear
    var particleColorB: Color = .clear
    
    var particleSize: CGFloat = 5
    var particleOpacity: Double = 0
}
