import SwiftUI

struct DifficultyView: View {
    @Binding var selectedColor: Color
    @Binding var selectedSpeed: Int
    
    @State private var goToGame = false
    
    let difficulties: [(String, Int)] = [
        ("Easy", 2),
        ("Normal", 4),
        ("Hard", 7)
    ]
    
    var body: some View {
        ScrollView { // прокрутка
            VStack(spacing: 12) {
                
                // Карточка сложности
                VStack(alignment: .leading, spacing: 12) {
                    Text("Difficulty")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    ForEach(difficulties, id: \.0) { name, speed in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(name)
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            
                            if speed == selectedSpeed {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 3)
                                    .cornerRadius(2)
                                    .padding(.leading, 2)
                                    .frame(width: 80, alignment: .leading)
                            }
                        }
                        .onTapGesture { selectedSpeed = speed }
                    }
                }
                .padding(12)
                .background(Color(red: 0.12, green: 0.12, blue: 0.16))
                .cornerRadius(14)
                
                
                // Кнопка запуска игры
                Button(action: {
                    goToGame = true
                }) {
                    Text("START")
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
            }
            .padding()
        }
        .background(Color(red: 0.05, green: 0.05, blue: 0.07))
        .navigationDestination(isPresented: $goToGame) {
            GameView(snakeColor: selectedColor, speed: selectedSpeed)
        }
    }
}
