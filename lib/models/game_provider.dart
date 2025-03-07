import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_model.dart';

class GameProvider extends ChangeNotifier {
  final GameModel _gameModel = GameModel();
  bool _soundEnabled = true;
  bool _hapticEnabled = true;
  String _theme = 'classic'; // classic, neon, minimalist, etc.

  // Game history
  List<Map<String, dynamic>> _gameHistory = [];

  // Getters
  GameModel get gameModel => _gameModel;
  bool get soundEnabled => _soundEnabled;
  bool get hapticEnabled => _hapticEnabled;
  String get theme => _theme;
  List<Map<String, dynamic>> get gameHistory => _gameHistory;

  // Constructor - load settings from shared preferences
  GameProvider() {
    _loadSettings();
    _loadGameHistory();
  }

  // Load settings from shared preferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
    _hapticEnabled = prefs.getBool('hapticEnabled') ?? true;
    _theme = prefs.getString('theme') ?? 'classic';

    // Load game mode
    final gameModeString = prefs.getString('gameMode') ?? 'playerVsPlayer';
    _gameModel.gameMode = _stringToGameMode(gameModeString);

    // Load player symbol
    final playerSymbolString = prefs.getString('playerSymbol') ?? 'classic';
    _gameModel.playerSymbol = _stringToPlayerSymbol(playerSymbolString);

    notifyListeners();
  }

  // Load game history
  Future<void> _loadGameHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('gameHistory') ?? [];

    _gameHistory = historyList.map((item) {
      final Map<String, dynamic> gameData = {};
      item.split(',').forEach((entry) {
        final parts = entry.split(':');
        if (parts.length == 2) {
          gameData[parts[0]] = parts[1];
        }
      });
      return gameData;
    }).toList();

    notifyListeners();
  }

  // Save settings to shared preferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('hapticEnabled', _hapticEnabled);
    await prefs.setString('theme', _theme);
    await prefs.setString('gameMode', _gameModeToString(_gameModel.gameMode));
    await prefs.setString(
        'playerSymbol', _playerSymbolToString(_gameModel.playerSymbol));
  }

  // Save game history
  Future<void> _saveGameHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = _gameHistory.map((item) {
      return item.entries
          .map((entry) => '${entry.key}:${entry.value}')
          .join(',');
    }).toList();

    await prefs.setStringList('gameHistory', historyList);
  }

  // Helper methods for game mode conversion
  String _gameModeToString(GameMode mode) {
    switch (mode) {
      case GameMode.playerVsPlayer:
        return 'playerVsPlayer';
      case GameMode.easyAI:
        return 'easyAI';
      case GameMode.mediumAI:
        return 'mediumAI';
      case GameMode.hardAI:
        return 'hardAI';
      default:
        return 'playerVsPlayer';
    }
  }

  GameMode _stringToGameMode(String mode) {
    switch (mode) {
      case 'playerVsPlayer':
        return GameMode.playerVsPlayer;
      case 'easyAI':
        return GameMode.easyAI;
      case 'mediumAI':
        return GameMode.mediumAI;
      case 'hardAI':
        return GameMode.hardAI;
      default:
        return GameMode.playerVsPlayer;
    }
  }

  // Helper methods for player symbol conversion
  String _playerSymbolToString(PlayerSymbol symbol) {
    switch (symbol) {
      case PlayerSymbol.classic:
        return 'classic';
      case PlayerSymbol.heart:
        return 'heart';
      case PlayerSymbol.star:
        return 'star';
      case PlayerSymbol.diamond:
        return 'diamond';
      default:
        return 'classic';
    }
  }

  PlayerSymbol _stringToPlayerSymbol(String symbol) {
    switch (symbol) {
      case 'classic':
        return PlayerSymbol.classic;
      case 'heart':
        return PlayerSymbol.heart;
      case 'star':
        return PlayerSymbol.star;
      case 'diamond':
        return PlayerSymbol.diamond;
      default:
        return PlayerSymbol.classic;
    }
  }

  // Make a move
  bool makeMove(int row, int col) {
    final result = _gameModel.makeMove(row, col);
    if (result) {
      notifyListeners();

      // If game is over, add to history
      if (_gameModel.gameState != GameState.playing) {
        _addGameToHistory();
      }
    }
    return result;
  }

  // Add current game to history
  void _addGameToHistory() {
    final gameResult = {
      'date': DateTime.now().toString(),
      'gameMode': _gameModeToString(_gameModel.gameMode),
      'result': _gameStateToString(_gameModel.gameState),
      'xScore': _gameModel.xScore.toString(),
      'oScore': _gameModel.oScore.toString(),
      'draws': _gameModel.draws.toString(),
    };

    _gameHistory.add(gameResult);
    _saveGameHistory();
  }

  String _gameStateToString(GameState state) {
    switch (state) {
      case GameState.xWon:
        return 'X Won';
      case GameState.oWon:
        return 'O Won';
      case GameState.draw:
        return 'Draw';
      default:
        return 'Playing';
    }
  }

  // Reset the game board
  void resetBoard() {
    _gameModel.resetBoard();
    notifyListeners();
  }

  // Reset scores
  void resetScores() {
    _gameModel.resetScores();
    notifyListeners();
  }

  // Undo the last move
  bool undoMove() {
    final result = _gameModel.undoMove();
    if (result) {
      notifyListeners();
    }
    return result;
  }

  // Set game mode
  void setGameMode(GameMode mode) {
    _gameModel.gameMode = mode;
    _saveSettings();
    notifyListeners();
  }

  // Set player symbol
  void setPlayerSymbol(PlayerSymbol symbol) {
    _gameModel.playerSymbol = symbol;
    _saveSettings();
    notifyListeners();
  }

  // Toggle sound
  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    _saveSettings();
    notifyListeners();
  }

  // Toggle haptic feedback
  void toggleHaptic() {
    _hapticEnabled = !_hapticEnabled;
    _saveSettings();
    notifyListeners();
  }

  // Set theme
  void setTheme(String newTheme) {
    _theme = newTheme;
    _saveSettings();
    notifyListeners();
  }

  // Clear game history
  void clearGameHistory() {
    _gameHistory.clear();
    _saveGameHistory();
    notifyListeners();
  }
}
