import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SoundUtils {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _assetsExist = false;

  // Sound effects
  static const String _tapSound = 'tap.mp3';
  static const String _winSound = 'win.mp3';
  static const String _drawSound = 'draw.mp3';
  static const String _errorSound = 'error.mp3';
  static const String _menuSound = 'menu.mp3';

  // Initialize sound assets
  static Future<void> preloadSounds() async {
    // Check if assets exist - we'll skip playing sounds if they don't
    try {
      await rootBundle.load('lib/assets/$_tapSound');
      _assetsExist = true;
    } catch (e) {
      _assetsExist = false;
      print('Sound assets not found. Sound will be disabled.');
    }
    return;
  }

  // Play tap sound
  static Future<void> playTapSound(
      {bool haptic = true, bool soundEnabled = true}) async {
    if (haptic) {
      HapticFeedback.selectionClick();
    }

    if (soundEnabled && _assetsExist) {
      try {
        await _audioPlayer.play(AssetSource(_tapSound));
      } catch (e) {
        // Handle error silently
      }
    }
  }

  // Play win sound
  static Future<void> playWinSound(
      {bool haptic = true, bool soundEnabled = true}) async {
    if (haptic) {
      HapticFeedback.heavyImpact();
    }

    if (soundEnabled && _assetsExist) {
      try {
        await _audioPlayer.play(AssetSource(_winSound));
      } catch (e) {
        // Handle error silently
      }
    }
  }

  // Play draw sound
  static Future<void> playDrawSound(
      {bool haptic = true, bool soundEnabled = true}) async {
    if (haptic) {
      HapticFeedback.mediumImpact();
    }

    if (soundEnabled && _assetsExist) {
      try {
        await _audioPlayer.play(AssetSource(_drawSound));
      } catch (e) {
        // Handle error silently
      }
    }
  }

  // Play error sound
  static Future<void> playErrorSound(
      {bool haptic = true, bool soundEnabled = true}) async {
    if (haptic) {
      HapticFeedback.vibrate();
    }

    if (soundEnabled && _assetsExist) {
      try {
        await _audioPlayer.play(AssetSource(_errorSound));
      } catch (e) {
        // Handle error silently
      }
    }
  }

  // Play menu sound
  static Future<void> playMenuSound(
      {bool haptic = true, bool soundEnabled = true}) async {
    if (haptic) {
      HapticFeedback.lightImpact();
    }

    if (soundEnabled && _assetsExist) {
      try {
        await _audioPlayer.play(AssetSource(_menuSound));
      } catch (e) {
        // Handle error silently
      }
    }
  }

  // Dispose audio player
  static void dispose() {
    _audioPlayer.dispose();
  }
}
