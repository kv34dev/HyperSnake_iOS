import SwiftUI
import Combine

struct GameView: View {
    let snakeColor: Color
    let speed: Int
    
    @State private var snake: [CGPoint] = [CGPoint(x: 5, y: 5)]
    @State private var food = CGPoint(x: 2, y: 2)
    @State private var dir = CGPoint(x: 1, y: 0)
    
    @State private var gameOver = false
    
    let gridSize = 12
    
    // Значение Digital Crown
    @State private var crownValue: Double = 0
    @State private var lastCrownValue: Double = 0
    @State private var accumulatedDelta: Double = 0
    
    let crownThreshold: Double = 10
    
    var body: some View {
        VStack {
            if gameOver {
                Text("Game Over")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.red)
                
                Button("Restart") {
                    restart()
                }
                .buttonStyle(.bordered)
            } else {
                GeometryReader { geo in
                    let cell = geo.size.width / CGFloat(gridSize)
                    
                    ZStack {
                        // Еда
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.red)
                            .frame(width: cell, height: cell)
                            .position(x: food.x * cell + cell/2,
                                      y: food.y * cell + cell/2)
                        
                        // Змейка
                        ForEach(0..<snake.count, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 6)
                                .fill(snakeColor)
                                .frame(width: cell, height: cell)
                                .position(x: snake[i].x * cell + cell/2,
                                          y: snake[i].y * cell + cell/2)
                        }
                    }
                }
            }
        }
        .padding()
        // Привязка вращения Digital Crown
        .focusable(true)
        .digitalCrownRotation($crownValue, from: -100, through: 100, by: 1, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
        .onChange(of: crownValue) { newValue in
            handleCrownRotation(newValue: newValue)
        }
        .onAppear { startLoop() }
    }
    
    func handleCrownRotation(newValue: Double) {
        let delta = newValue - lastCrownValue
        lastCrownValue = newValue
        
        accumulatedDelta += delta
        
        if accumulatedDelta >= crownThreshold {
            rotateClockwise()
            accumulatedDelta = 0
        } else if accumulatedDelta <= -crownThreshold {
            rotateCounterClockwise()
            accumulatedDelta = 0
        }
    }

    
    func rotateClockwise() {
        if dir.x == 1 { dir = CGPoint(x: 0, y: 1) }
        else if dir.x == -1 { dir = CGPoint(x: 0, y: -1) }
        else if dir.y == 1 { dir = CGPoint(x: -1, y: 0) }
        else if dir.y == -1 { dir = CGPoint(x: 1, y: 0) }
    }
    
    func rotateCounterClockwise() {
        if dir.x == 1 { dir = CGPoint(x: 0, y: -1) }
        else if dir.x == -1 { dir = CGPoint(x: 0, y: 1) }
        else if dir.y == 1 { dir = CGPoint(x: 1, y: 0) }
        else if dir.y == -1 { dir = CGPoint(x: -1, y: 0) }
    }
    
    func startLoop() {
        Timer.scheduledTimer(withTimeInterval: 1.0 / Double(speed), repeats: true) { _ in
            update()
        }
    }
    
    func update() {
        if gameOver { return }
        
        let head = snake.first!
        let new = CGPoint(x: head.x + dir.x, y: head.y + dir.y)
        
        if new.x < 0 || new.x >= CGFloat(gridSize) ||
            new.y < 0 || new.y >= CGFloat(gridSize) ||
            snake.contains(new) {
            gameOver = true
            return
        }
        
        snake.insert(new, at: 0)
        
        if new == food {
            spawnFood()
        } else {
            snake.removeLast()
        }
    }
    
    func spawnFood() {
        food = CGPoint(
            x: CGFloat(Int.random(in: 0..<gridSize)),
            y: CGFloat(Int.random(in: 0..<gridSize))
        )
    }
    
    func restart() {
        snake = [CGPoint(x: 5, y: 5)]
        dir = CGPoint(x: 1, y: 0)
        crownValue = 0
        lastCrownValue = 0
        accumulatedDelta = 0
        spawnFood()
        gameOver = false
    }
}
