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

## Development

### Prerequisites

- Flutter SDK (3.19.0 or later)
- Android Studio / VS Code
- Git

### Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Deployment

This app uses GitHub Actions for automated deployment to the Google Play Store.

### Setup Requirements

1. Google Play Console account
2. Service account with Play Store API access
3. GitHub repository secrets configured

### Deployment Process

1. Push to the `main` branch to trigger automatic deployment
2. Or manually trigger the workflow from the GitHub Actions tab

The app will be deployed to the internal testing track on the Play Store.

### Manual Deployment

To deploy manually:

1. Build the release APK:
   ```bash
   flutter build apk --release
   ```
2. The APK will be in `build/app/outputs/flutter-apk/app-release.apk`

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Flutter team for the amazing framework
- Font Awesome for the icons
- Google Fonts for the typography
