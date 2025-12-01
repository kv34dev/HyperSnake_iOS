import SwiftUI

struct ContentView: View {
    @State private var color = Color.green
    @State private var speed = 4
    
    var body: some View {
        NavigationStack {
            ColorSelectionView(selectedColor: $color,
                               selectedSpeed: $speed)
        }
    }
}

#Preview {
    ContentView()
}
