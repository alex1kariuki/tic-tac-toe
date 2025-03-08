# Tic Tac Toe

A modern, feature-rich Tic Tac Toe game built with Flutter for multiple platforms.

[![Available on Android](https://img.shields.io/badge/Available%20on-Android-brightgreen.svg)](https://github.com/yourusername/tictactoe)
[![Available on iOS](https://img.shields.io/badge/Available%20on-iOS-blue.svg)](https://github.com/yourusername/tictactoe)
[![Available on Web](https://img.shields.io/badge/Available%20on-Web-orange.svg)](https://github.com/yourusername/tictactoe)

## Features

- **Beautiful UI with Animations**: Smooth animations and transitions for a polished gaming experience
- **Multiple Game Modes**: 
  - Player vs Player - Challenge a friend on the same device
  - AI with three difficulty levels (Easy, Medium, Hard)
- **Customizable Themes**: Choose from Classic, Neon, Minimalist, and Dark themes
- **Sound Effects and Haptic Feedback**: Immersive audio and tactile feedback (can be toggled on/off)
- **Game History**: Track your game results and statistics
- **Score Tracking**: Keep track of wins, losses, and draws
- **Undo Functionality**: Made a mistake? Undo your last move!
- **Responsive Design**: Optimized for various screen sizes and orientations

## Screenshots

### Android & iOS

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/6f8a3c11-f368-45be-9abc-c0aad9bca441"  width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/72bd28bc-a4cc-4cdf-a722-c9ff1646e1f7"  width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/3756e55a-dfc5-4c34-98cd-462054c7f702"  width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/ace7aaf4-beba-4ade-b6c0-4b3b556949bd"  width="200"/></td>
<td><img src="https://github.com/user-attachments/assets/d4aa6609-c5a2-499c-95c8-071132756d09"  width="200"/></td>
  </tr>
</table>

### Web

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/23a33359-dec9-440f-96e3-5d3bd99c3dd8" width="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/adcfe661-e356-47ef-9bf0-48fe2c110825" width="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/e8b8f5c7-a8b4-443e-ab53-df463619bf0d" width="400"/></td>
  </tr>
</table>

## Getting Started

### Prerequisites

- Flutter SDK (3.6.1 or higher)
- For Android: Android Studio with an emulator or physical device
- For iOS: Xcode with a simulator or physical device
- For Web: Chrome or another supported browser

### Installation

1. Clone the repository
```bash
git clone https://github.com/alex1kariuki/tictactoe.git
```

2. Navigate to the project directory
```bash
cd tictactoe
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app on your preferred platform
```bash
# For Android
flutter run -d android

# For iOS
flutter run -d ios

# For Web
flutter run -d chrome
```

## How to Play

1. **Choose your game mode**:
   - Player vs Player: Play against a friend on the same device
   - Easy AI: Play against a computer opponent that makes random moves
   - Medium AI: Play against a computer opponent with moderate strategy
   - Hard AI: Play against a computer opponent with advanced strategy

2. **Game Rules**:
   - Players take turns placing their mark (X or O) on the 3x3 grid
   - The first player to get three marks in a row (horizontally, vertically, or diagonally) wins
   - If all cells are filled and no player has three in a row, the game ends in a draw

3. **Controls**:
   - Tap on any empty cell to place your mark
   - Use the "Undo" button to revert the last move
   - Use the "Reset" button to start a new game with the same settings

## Customization

- **Themes**: Switch between different visual themes in the Settings tab
- **Sound**: Toggle sound effects on/off
- **Haptic Feedback**: Toggle haptic feedback on/off

## Project Structure

- `lib/models/`: Contains the game logic and state management
- `lib/screens/`: Contains the main screens of the app
- `lib/widgets/`: Contains reusable UI components
- `lib/utils/`: Contains utility classes for themes, sounds, etc.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Flutter team for the amazing framework
- Font Awesome for the icons
- Google Fonts for the typography
