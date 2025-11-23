# HyperSnake — iOS Edition

HyperSnake is a classic “Snake” arcade game fully ported to iOS from the original Python/Pygame version. The game is built using **SpriteKit** and supports **portrait orientation only**.

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

## How to Install & Run

1. Clone the repository:
```
git clone https://github.com/kv34dev/HyperSnake_WatchOS
```
2. Open the project in Xcode.
3. Connect your Apple Watch or use an Apple Watch simulator.
4. Build & Run the WatchOS target.


## Project Structure
```
HyperSnake_iOS.xcodeproj/
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
