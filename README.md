# HyperSnake — iOS Edition

HyperSnake is a classic “Snake” arcade game fully ported to iOS from the original Python/Pygame version. The game is built using **SpriteKit** and supports **portrait orientation only**.

![screenshot](https://github.com/user-attachments/assets/e6a2f4f2-5956-47cd-87e4-b7cd2cfc479e)

## Features

- Choose your snake color
- Select difficulty: Easy, Normal, Hard
- Grid-based movement for precise control
- Score displayed on screen
- Simple touch controls (tap/swipe to change direction)
- Game Over screen with option to restart
- Supports iPhone and iPad (Portrait Mode only)

## Controls

- **Swipe or tap** on the screen to change the snake's direction.
- **Menu** allows selecting snake color and difficulty.
- **START button** launches the game.
- After Game Over, **tap the screen** to return to the menu.

# Apple Watch Companion App

HyperSnake also includes a fully featured **Apple Watch Edition**, built with SwiftUI and optimized for all modern Apple Watch sizes. This version faithfully recreates the classic HyperSnake experience with:


![photo-output](https://github.com/user-attachments/assets/6476af88-6e80-460c-a95b-4cfc496ecc9b)

- Color selection (9 snake colors)  
- Easy / Normal / Hard difficulty levels  
- Smooth timer-based gameplay  
- **Digital Crown controls** for precise turning  
- Scrollable menus using the Crown  

The WatchOS app is included in the project and can be built and run directly on a real watch or simulator. It is a complete, independent port of the original Python game designed specifically for the Apple Watch interface.

### Digital Crown-Based Movement 
Control the snake by rotating the Digital Crown on your Apple Watch: 

- Rotate clockwise → turn the snake 90° clockwise
- Rotate counterclockwise → turn the snake 90° counterclockwise

Each rotation of the crown corresponds to a single turn of the snake.

# How to Install & Run

1. Clone the repository:
```
git clone https://github.com/kv34dev/HyperSnake_iOS
```
2. Open the project in Xcode.
3. Select the target you want to run:
   - **HyperSnake_iOS** for iPhone or iPad  
   - **HyperSnake_WatchOS** for Apple Watch  
4. Connect your device (iPhone, iPad, or Apple Watch) or use the appropriate simulator.
5. Build & Run the selected target.


## Project Structure
```
HyperSnake_iOS.xcodeproj/
HyperSanake_WatchOS Watch App
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   └── AppIcon.appiconset
│       ├── Contents.json
│       └── icon.png
├── Contents.json
├── ColorSelectionView.swift
├── ContentView.swift
├── DifficultyView.swift
├── GameView.swift
└── HyperSanake_WatchOSApp.swift
HyperSnake_iOS/
├─ Assets.xcassets/
│   ├─ Contents.json
│   ├─ AccentColor.colorset/
│   │   └─ Contents.json
│   └─ AppIcon.appiconset/
│       ├─ icon.jpeg
│       └─ Contents.json
├─ Base.lproj/
│   ├─ LaunchScreen.storyboard
│   └─ Main.storyboard
├─ Actions.sks
├─ AppDelegate.swift
├─ GameScene.sks
├─ GameScene.swift
├─ GameViewController.swift
└─ MenuScene.swift
```
