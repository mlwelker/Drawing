
import SwiftUI

struct Arrow: Shape {
    var width: Double
    var inset: Double
    
    var animatableData: Double {
        get { width }
        set { width = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX - width, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - inset))
        path.addLine(to: CGPoint(x: rect.maxX + width, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ContentView: View {
    @State private var insetAmount = 40.0
    @State private var arrowWidth = 40.0
    
    let arrowWidths = [10.0, 40.0, 80.0, 100.0]
    
    var body: some View {
        VStack {
            Spacer()
            
            Arrow(width: arrowWidth, inset: insetAmount)
                .fill(.blue)
                .frame(width: 100, height: 300)
                .onTapGesture {
                    withAnimation {
                        arrowWidth = Double.random(in: 10.0...100.0)
                    }
                }
            
            Form {
                Section {
                    Picker("Arrow width", selection: $arrowWidth) {
                        ForEach(arrowWidths, id: \.self) { width in
                            Text("\(width, format: .number)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Arrow Width")
                }
                
                Section {
                    Slider(value: $insetAmount, in: 0...100)
                } header: {
                    Text("Inset")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
