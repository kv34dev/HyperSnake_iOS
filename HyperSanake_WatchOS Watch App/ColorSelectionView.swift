import SwiftUI

struct ColorSelectionView: View {
    @Binding var selectedColor: Color
    @Binding var selectedSpeed: Int
    
    @State private var goToDifficulty = false
    
    let snakeColors: [(String, Color)] = [
        ("Red", Color(.sRGB, red: 1, green: 0.27, blue: 0.27)),
        ("Green", Color(.sRGB, red: 0.22, green: 1, blue: 0.078)),
        ("Purple", Color(.sRGB, red: 0.70, green: 0.35, blue: 1)),
        ("Orange", Color(.sRGB, red: 1, green: 0.59, blue: 0.24)),
        ("Cyan", Color.cyan),
        ("Pink", Color(.sRGB, red: 1, green: 0.39, blue: 0.78)),
        ("Yellow", Color(.sRGB, red: 1, green: 0.88, blue: 0.31)),
        ("Blue", Color(.sRGB, red: 0, green: 0.47, blue: 1)),
        ("White", Color(.sRGB, red: 0.94, green: 0.94, blue: 0.94))
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                Text("HyperSnake")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 6)
                
                // Карточка цветов
                VStack(alignment: .leading, spacing: 8) {
                    Text("Snake Color")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(36), spacing: 6), count: 3)) {
                        ForEach(snakeColors, id: \.0) { _, col in
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(col)
                                    .frame(width: 32, height: 32)
                                
                                if selectedColor == col {
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.white, lineWidth: 2)
                                        .frame(width: 32, height: 32)
                                }
                            }
                            .onTapGesture { selectedColor = col }
                        }
                    }
                }
                .padding(10)
                .background(Color(red: 0.12, green: 0.12, blue: 0.16))
                .cornerRadius(14)
                
                Button {
                    goToDifficulty = true
                } label: {
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .background(Color(red: 0.05, green: 0.05, blue: 0.07))
        .navigationDestination(isPresented: $goToDifficulty) {
            DifficultyView(selectedColor: $selectedColor, selectedSpeed: $selectedSpeed)
        }
    }
}
