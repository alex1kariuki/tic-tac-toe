import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SoundUtils {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _assetsExist = false;

  // Sound effects
  static const String _tapSound = 'lib/assets/tap.wav';
  static const String _winSound = 'lib/assets/win.mp3';
  static const String _drawSound = 'lib/assets/draw.mp3';
  static const String _errorSound = 'lib/assets/error.mp3';
  static const String _menuSound = 'lib/assets/menu.mp3';

  // Initialize sound assets
  static Future<void> preloadSounds() async {
    // Check if assets exist - we'll skip playing sounds if they don't
    try {
      await rootBundle.load(_tapSound);
      _assetsExist = true;
      print('Sound assets loaded successfully.');
    } catch (e) {
      _assetsExist = false;
      print('Sound assets not found. Sound will be disabled. Error: $e');
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
        print('Error playing tap sound: $e');
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
        print('Error playing win sound: $e');
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
        print('Error playing draw sound: $e');
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
        print('Error playing error sound: $e');
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
        print('Error playing menu sound: $e');
      }
    }
  }

  // Dispose audio player
  static void dispose() {
    _audioPlayer.dispose();
  }
}
