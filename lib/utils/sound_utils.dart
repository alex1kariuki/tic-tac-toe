import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SoundUtils {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // Sound effects
  static const String _tapSound = 'tap.mp3';
  static const String _winSound = 'win.mp3';
  static const String _drawSound = 'draw.mp3';
  static const String _errorSound = 'error.mp3';
  static const String _menuSound = 'menu.mp3';

  // Initialize sound assets
  static Future<void> preloadSounds() async {
    // This would be implemented if we had actual sound files
    // For now, we'll just return
    return;
  }

  // Play tap sound
  static Future<void> playTapSound(
      {bool haptic = true, bool soundEnabled = true}) async {
    if (haptic) {
      HapticFeedback.selectionClick();
    }

    if (soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource(_tapSound));
      } catch (e) {
        // Handle error or use fallback sound
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

    if (soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource(_winSound));
      } catch (e) {
        // Handle error or use fallback sound
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

    if (soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource(_drawSound));
      } catch (e) {
        // Handle error or use fallback sound
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

    if (soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource(_errorSound));
      } catch (e) {
        // Handle error or use fallback sound
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

    if (soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource(_menuSound));
      } catch (e) {
        // Handle error or use fallback sound
        print('Error playing menu sound: $e');
      }
    }
  }

  // Dispose audio player
  static void dispose() {
    _audioPlayer.dispose();
  }
}
