import SwiftUI

struct ContentView: View {
    
    typealias OnTapGesture = (Bool) -> Void
    
    @State private var isOpen: Bool = false
    @State private var animations: [Bool] = [false, false, false]
    
    private let color: Color
    private let onTap: OnTapGesture
    
    init(color: Color, onTap: @escaping OnTapGesture) {
        self.color = color
        self.onTap = onTap
    }
    
    var body: some View {
        GeometryReader { reader in
            let fullWidth: CGFloat = reader.size.width
            let fullHeight: CGFloat = reader.size.height
            
            let margin: CGFloat = fullWidth * 0.1
            
            let width: CGFloat = reader.size.width - (margin * 2)
            let height: CGFloat = (reader.size.height - (margin * 4)) / 4
            
            let midX = fullWidth / 2
            let midY = fullHeight / 2
            
            ZStack {
                color
                    .clipShape(Capsule())
                    .frame(width: width, height: height)
                    .position(x: midX, y: animations[0] ? midY : midY-height-margin)
                    .rotationEffect(Angle(degrees: animations[2] ? 135 : 0))
                
                color
                    .clipShape(Capsule())
                    .opacity(animations[1] ? 0 : 1)
                    .frame(width: width, height: height)
                    .position(x: midX, y: midY)
                
                color
                    .clipShape(Capsule())
                    .frame(width: width, height: height)
                    .position(x: midX, y: animations[0] ? midY : midY + height + margin)
                    .rotationEffect(Angle(degrees: animations[2] ? 45 : 0))
            }
            .background(Color.clear)
            .onTapGesture {
                self.onTap(isOpen)
                
                isOpen.toggle()
                
                let index0 = isOpen ? 0 : 2
                let index1 = 1
                let index2 = isOpen ? 2 : 0
                
                withAnimation {
                    animations[index0] = isOpen
                }
                
                let animation = Animation.spring(response: 1, dampingFraction: 0.5, blendDuration: 200).speed(3)
                
                let animation2 = Animation
                    .spring(response: 1, dampingFraction: 0.5, blendDuration: 200)
                    .speed(isOpen ? 1 : 0.45)
                
                withAnimation(animation2) {
                    animations[index1] = isOpen
                }
                
                withAnimation(animation.delay(0.4)) {
                    animations[index2] = isOpen
                }
            }
        }
    }
}

extension Color {
    static let main: Color = Color(.sRGB, red: 17/255, green: 57/255, blue: 75/255, opacity: 1)
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            HStack {
                ContentView(color: .main) { isOpen in
                    print(isOpen)
                }
                .frame(width: 35, height: 35)
                
                Text("Super App")
                    .font(Font.custom("AvenirNext-DemiBold", size: 20))
                    .padding(.leading, 10)
                    .foregroundColor(.main)
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
        HStack {
            ContentView(color: .main) { isOpen in
                print(isOpen)
            }
            .frame(width: 100, height: 100)
            
            ContentView(color: .blue) { isOpen in
                print(isOpen)
            }
            .frame(width: 100, height: 100)
        }
    }
}
