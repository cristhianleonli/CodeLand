
protocol Describable {
    var visibleName: String { get }
}

enum Something: Describable, CaseIterable {
    case some1
    case some2
    case some3
    
    var visibleName: String {
        return "\(self)"
    }
}

import SwiftUI

struct ContentView: View {
    
    @State var selected = Something.some1
    
    var body: some View {
        //        WheelPicker(elements: Something.allCases, selected: $selected)
        CustomPicker(
            data: Something.allCases,
            selected: $selected,
            preferredSize: CGSize(width: 150, height: 60)
        )
        .frame(width: 150, height: 160)
        .clipped()
        .background(Color.blue)
    }
}

struct CustomPicker<T: Describable>: UIViewRepresentable {
    let data: [T]
    @Binding var selected: T
    let preferredSize: CGSize
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self) { value in
            self.selected = value
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var picker: CustomPicker
        let onChange: (T) -> Void
        
        init(picker: CustomPicker, onChange: @escaping (T) -> Void) {
            self.picker = picker
            self.onChange = onChange
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return picker.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let view = UIView()
            view.backgroundColor = .red
            
            let label = UILabel()
            label.text = picker.data[row].visibleName
            label.frame = CGRect(x: 0, y: 0, width: picker.preferredSize.width, height: picker.preferredSize.height)
            label.textAlignment = .center
            
            view.addSubview(label)
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            onChange(picker.data[row])
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return picker.preferredSize.width
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return picker.preferredSize.height
        }
    }
    
}


//            if #available(iOS 14.0, *)
//            {
////                pickerView.subviews[1].backgroundColor = .clear
//            }


struct WheelPicker<Element: Equatable & Describable & Hashable>: View {
    
    let elements: [Element]
    @Binding var selected: Element
    @State private var position = 0
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    Text("")
                        .frame(width: reader.size.width, height: reader.size.height / 3)
                        .background(Color.pink)
                    
                    ForEach(0..<10) { index in
                        Text("some \(index)")
                            .frame(width: reader.size.width, height: reader.size.height / 3)
                            .background(Color.orange)
                    }
                    
                    Text("")
                        .frame(width: reader.size.width, height: reader.size.height / 3)
                        .background(Color.pink)
                }
                .background(Color.blue)
                .onChange(of: position, perform: { value in
                    print(value)
                })
            }
            .frame(width: reader.size.width)
            
            
        }
        .background(Color.red)
        
        //        Picker(selection: $selected, label: Text("DefaultPicker")) {
        //            ForEach(elements, id: \.self) { element in
        //                VStack {
        //                    Text(element.visibleName)
        //                        .multilineTextAlignment(.center)
        ////                        .font(Fonts.Picker.title)
        ////                        .foregroundColor(Colors.Home.pickerTitle)
        //                }
        ////                .frame(height: 50)
        //                .background(Color.red)
        //            }
        //        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
