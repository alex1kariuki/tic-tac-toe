import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTheme {
  final Color backgroundColor;
  final Color boardColor;
  final Color gridLineColor;
  final Color xColor;
  final Color oColor;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color winLineColor;
  final TextStyle titleStyle;
  final TextStyle bodyStyle;
  final TextStyle scoreStyle;
  final BoxDecoration cellDecoration;
  final BoxDecoration boardDecoration;

  const GameTheme({
    required this.backgroundColor,
    required this.boardColor,
    required this.gridLineColor,
    required this.xColor,
    required this.oColor,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.winLineColor,
    required this.titleStyle,
    required this.bodyStyle,
    required this.scoreStyle,
    required this.cellDecoration,
    required this.boardDecoration,
  });
}

class ThemeUtils {
  static GameTheme getTheme(String themeName) {
    switch (themeName) {
      case 'classic':
        return _classicTheme();
      case 'neon':
        return _neonTheme();
      case 'minimalist':
        return _minimalistTheme();
      case 'dark':
        return _darkTheme();
      default:
        return _classicTheme();
    }
  }

  static GameTheme _classicTheme() {
    return GameTheme(
      backgroundColor: const Color(0xFFF5F5F5),
      boardColor: Colors.white,
      gridLineColor: Colors.black87,
      xColor: Colors.blue,
      oColor: Colors.red,
      textColor: Colors.black87,
      buttonColor: Colors.blue,
      buttonTextColor: Colors.white,
      winLineColor: Colors.green,
      titleStyle: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyStyle: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black87,
      ),
      scoreStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      cellDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      boardDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }

  static GameTheme _neonTheme() {
    return GameTheme(
      backgroundColor: const Color(0xFF121212),
      boardColor: const Color(0xFF1E1E1E),
      gridLineColor: const Color(0xFF00FFFF),
      xColor: const Color(0xFFFF00FF),
      oColor: const Color(0xFF00FF00),
      textColor: Colors.white,
      buttonColor: const Color(0xFF00FFFF),
      buttonTextColor: Colors.black,
      winLineColor: const Color(0xFFFFFF00),
      titleStyle: GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF00FFFF),
        shadows: [
          const Shadow(
            color: Color(0xFF00FFFF),
            blurRadius: 10,
          ),
        ],
      ),
      bodyStyle: GoogleFonts.orbitron(
        fontSize: 16,
        color: Colors.white,
      ),
      scoreStyle: GoogleFonts.orbitron(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        shadows: [
          const Shadow(
            color: Color(0xFF00FFFF),
            blurRadius: 5,
          ),
        ],
      ),
      cellDecoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF00FFFF),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF00FFFF),
            blurRadius: 5,
          ),
        ],
      ),
      boardDecoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00FFFF),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF00FFFF),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }

  static GameTheme _minimalistTheme() {
    return GameTheme(
      backgroundColor: Colors.white,
      boardColor: Colors.white,
      gridLineColor: const Color(0xFFDDDDDD),
      xColor: Colors.black,
      oColor: Colors.black,
      textColor: Colors.black,
      buttonColor: Colors.white,
      buttonTextColor: Colors.black,
      winLineColor: Colors.grey,
      titleStyle: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      bodyStyle: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      scoreStyle: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      cellDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      boardDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
    );
  }

  static GameTheme _darkTheme() {
    return GameTheme(
      backgroundColor: const Color(0xFF121212),
      boardColor: const Color(0xFF1E1E1E),
      gridLineColor: const Color(0xFF333333),
      xColor: const Color(0xFF4285F4),
      oColor: const Color(0xFFEA4335),
      textColor: Colors.white,
      buttonColor: const Color(0xFF4285F4),
      buttonTextColor: Colors.white,
      winLineColor: const Color(0xFF34A853),
      titleStyle: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyStyle: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.white,
      ),
      scoreStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      cellDecoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      boardDecoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }
}
