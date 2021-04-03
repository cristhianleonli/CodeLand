import SwiftUI

struct ContentView: View {
    
    @State private var currentPage: Int = 0
    @State private var pageIndex: Int = 0
    @State private var textIndex: Int = 0
    @State private var backgroundIndex: Int = 0
    
    private let maxPage: Int = 3
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                // images
                ZStack {
                    // images extra background
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Image("onboarding_1b")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: 0, y: 0)
                                    .frame(width: reader.size.width)
                                    .opacity(backgroundIndex == 0 ? 1 : 0)
                                
                                Image("onboarding_2b")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: 0, y: 0)
                                    .frame(width: reader.size.width)
                                    .opacity(backgroundIndex == 1 ? 1 : 0)
                                
                                Image("onboarding_3b")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: 0, y: 0)
                                    .frame(width: reader.size.width)
                                    .opacity(backgroundIndex == 2 ? 1 : 0)
                            }
                        }
                        .content.offset(x: position(at: backgroundIndex, of: reader.size.width), y: 0)
                    }
                    
                    // images foreground
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Image("onboarding_1a")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: 0, y: 0)
                                    .frame(width: reader.size.width)
                                
                                Image("onboarding_2a")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: 0, y: 0)
                                    .frame(width: reader.size.width)
                                
                                Image("onboarding_3a")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: 0, y: 0)
                                    .frame(width: reader.size.width)
                            }
                        }
                        .content.offset(x: position(at: currentPage, of: reader.size.width), y: 0)
                        
                    }
                }
                .frame(width: reader.size.width, height: reader.size.height / 2)
                
                // Texts
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            textPage(title: Strings.title1, body: Strings.body1)
                                .frame(width: reader.size.width)
                                .opacity(textIndex == 0 ? 1 : 0)
                            
                            textPage(title: Strings.title2, body: Strings.body2)
                                .frame(width: reader.size.width)
                                .opacity(textIndex == 1 ? 1 : 0)
                            
                            textPage(title: Strings.title3, body: Strings.body3)
                                .frame(width: reader.size.width)
                                .opacity(textIndex == 2 ? 1 : 0)
                        }
                    }
                    .content.offset(x: position(at: textIndex, of: reader.size.width), y: 0)
                }
                .frame(width: reader.size.width)
                
                Spacer()
                
                // Page indicator
                HStack {
                    (pageIndex == 0 ? Color.main : Color.grayish)
                        .frame(width: pageIndex == 0 ? 30 : 10, height: 10)
                        .clipShape(Capsule())
                    
                    (pageIndex == 1 ? Color.main : Color.grayish)
                        .frame(width: pageIndex == 1 ? 30 : 10, height: 10)
                        .clipShape(Capsule())
                    
                    (pageIndex == 2 ? Color.main : Color.grayish)
                        .frame(width: pageIndex == 2 ? 30 : 10, height: 10)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 20)
                
                // bottom container
                HStack {
                    // back button
                    if currentPage > 0 {
                        Button(action: {
                            movePage(.backward)
                        }, label: {
                            Text(Strings.back)
                        })
                        .padding()
                        .padding(.horizontal, 20)
                        .font(.skipButton)
                        .foregroundColor(.grayish)
                    }
                    
                    Spacer()
                    
                    // next button
                    Button(action: {
                        movePage(.forward)
                    }, label: {
                        Text(currentPage == maxPage - 1 ? Strings.getStarted : Strings.next)
                    })
                    .padding()
                    .padding(.horizontal, 20)
                    .font(.nextButton)
                    .foregroundColor(.main)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 90)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }// end of geometry
    }
    
    private func movePage(_ direction: MoveDirection) {
        var page = currentPage
        switch direction {
        case .forward:
            page = (page == maxPage - 1) ? maxPage - 1 : page + 1
        case .backward:
            page = (page - 1 < 0) ? 0 : page - 1
        }
        
        // general animation
        withAnimation {
            currentPage = page
        }
        
        // page indicator animation
        withAnimation(Animation.easeIn.speed(1.5)) {
            pageIndex = page
        }
        
        // texts animation
        withAnimation(Animation.easeInOut.speed(0.8)) {
            textIndex = page
            backgroundIndex = page
        }
    }
    
    private func position(at index: Int, of width: CGFloat) -> CGFloat {
        let offset: CGFloat = 9
        
        switch index {
        case 0:
            return width + offset
        case 2:
            return -width - offset
        default:
            return 0
        }
    }
    
    private func textPage(title: String, body: String) -> some View {
        return VStack(spacing: 20) {
            Text(title).font(.textTitle)
            Text(body).font(.textBody).multilineTextAlignment(.center)
        }
        .padding()
    }
}





struct Strings {
    static let title1 = "Social Profiling"
    static let title2 = "Advance Settings"
    static let title3 = "All on your phone"
    
    static let body1 = "You can create a promo-company. The price is determined by you based on the number of views."
    static let body2 = "Track the popularity of promo-company. You can compare their performance and create reports."
    static let body3 = "You can enter discounts in promotions in your business by writing off the promocode."
    
    static let back = "Back"
    static let getStarted = "Get started"
    static let next = "Next"
}


extension Font {
    static let nextButton: Font = Font.custom("AvenirNext-Bold", size: 18)
    static let skipButton: Font = Font.custom("AvenirNext-Bold", size: 18)
    
    static let textTitle: Font = Font.custom("AvenirNext-Bold", size: 25)
    static let textBody: Font = Font.custom("AvenirNext-Regular", size: 18)
}

extension Color {
    static let main: Color = Color(.sRGB, red: 100/255, green: 99/255, blue: 255/255, opacity: 1)
    static let grayish: Color = Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 1)
}

enum MoveDirection {
    case forward
    case backward
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
