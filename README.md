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

### Android

<table>
  <tr>
    <td><img src="screenshots/android_classic.png" alt="Android Classic Theme" width="200"/></td>
    <td><img src="screenshots/android_neon.png" alt="Android Neon Theme" width="200"/></td>
    <td><img src="screenshots/android_minimalist.png" alt="Android Minimalist Theme" width="200"/></td>
    <td><img src="screenshots/android_dark.png" alt="Android Dark Theme" width="200"/></td>
  </tr>
  <tr>
    <td align="center">Classic Theme</td>
    <td align="center">Neon Theme</td>
    <td align="center">Minimalist Theme</td>
    <td align="center">Dark Theme</td>
  </tr>
</table>

### iOS

<table>
  <tr>
    <td><img src="screenshots/ios_classic.png" alt="iOS Classic Theme" width="200"/></td>
    <td><img src="screenshots/ios_neon.png" alt="iOS Neon Theme" width="200"/></td>
    <td><img src="screenshots/ios_minimalist.png" alt="iOS Minimalist Theme" width="200"/></td>
    <td><img src="screenshots/ios_dark.png" alt="iOS Dark Theme" width="200"/></td>
  </tr>
  <tr>
    <td align="center">Classic Theme</td>
    <td align="center">Neon Theme</td>
    <td align="center">Minimalist Theme</td>
    <td align="center">Dark Theme</td>
  </tr>
</table>

### Web

<table>
  <tr>
    <td><img src="screenshots/web_classic.png" alt="Web Classic Theme" width="400"/></td>
    <td><img src="screenshots/web_neon.png" alt="Web Neon Theme" width="400"/></td>
  </tr>
  <tr>
    <td align="center">Classic Theme</td>
    <td align="center">Neon Theme</td>
  </tr>
  <tr>
    <td><img src="screenshots/web_minimalist.png" alt="Web Minimalist Theme" width="400"/></td>
    <td><img src="screenshots/web_dark.png" alt="Web Dark Theme" width="400"/></td>
  </tr>
  <tr>
    <td align="center">Minimalist Theme</td>
    <td align="center">Dark Theme</td>
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
