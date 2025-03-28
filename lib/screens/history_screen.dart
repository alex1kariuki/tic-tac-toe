import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/game_provider.dart';
import '../utils/theme_utils.dart';
import '../utils/sound_utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final theme = ThemeUtils.getTheme(gameProvider.theme);
    final history = gameProvider.gameHistory;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Game History',
          style: theme.titleStyle.copyWith(fontSize: 20),
        ),
        backgroundColor: theme.boardColor,
        foregroundColor: theme.textColor,
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                _showClearHistoryDialog(context, gameProvider, theme);
              },
            ),
        ],
      ),
      body: history.isEmpty
          ? _buildEmptyHistory(theme)
          : _buildHistoryList(history, theme),
    );
  }

  Widget _buildEmptyHistory(GameTheme theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: theme.textColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No Game History Yet',
            style: theme.titleStyle.copyWith(
              color: theme.textColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete games to see your history here',
            style: theme.bodyStyle.copyWith(
              color: theme.textColor.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(
      List<Map<String, dynamic>> history, GameTheme theme) {
    if (history.isEmpty) {
      return _buildEmptyHistory(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        try {
          if (index < 0 || index >= history.length) {
            return _buildErrorHistoryItem(theme, index);
          }

          final gameData = history.length > index
              ? history[history.length - 1 - index]
              : null;

          if (gameData == null || gameData.isEmpty) {
            return _buildErrorHistoryItem(theme, index);
          }

          return _buildHistoryItem(gameData, theme, index);
        } catch (e) {
          print('Error building history item $index: $e');
          return _buildErrorHistoryItem(theme, index);
        }
      },
    );
  }

  Widget _buildErrorHistoryItem(GameTheme theme, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: theme.boardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: theme.textColor.withOpacity(0.2),
          child: Icon(
            Icons.error_outline,
            color: theme.textColor,
          ),
        ),
        title: Text(
          'Game Record ${index + 1}',
          style: theme.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textColor,
          ),
        ),
        subtitle: Text(
          'Unable to load game details',
          style: theme.bodyStyle.copyWith(
            fontSize: 12,
            color: theme.textColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
      Map<String, dynamic> gameData, GameTheme theme, int index) {
    DateTime date;
    String formattedDate;
    try {
      String dateStr = gameData['date'] ?? DateTime.now().toString();
      date = DateTime.parse(dateStr);
      formattedDate =
          '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error parsing date: $e');
      formattedDate = 'Unknown date';
    }

    final result = gameData['result'] ?? 'Unknown';
    final gameMode = gameData['gameMode'] ?? 'Unknown';

    int xScoreValue = 0, oScoreValue = 0;
    try {
      xScoreValue = int.tryParse(gameData['xScore'] ?? '0') ?? 0;
      oScoreValue = int.tryParse(gameData['oScore'] ?? '0') ?? 0;
    } catch (e) {
      print('Error parsing scores: $e');
    }

    final xScore = xScoreValue.toString();
    final oScore = oScoreValue.toString();

    Color resultColor = theme.textColor;
    IconData resultIcon = Icons.question_mark;

    // Safely determine result appearance
    try {
      switch (result) {
        case 'X Won':
          resultColor = theme.xColor;
          resultIcon = Icons.close;
          break;
        case 'O Won':
          resultColor = theme.oColor;
          resultIcon = Icons.circle_outlined;
          break;
        case 'Draw':
          resultColor = theme.textColor;
          resultIcon = Icons.balance;
          break;
        default:
          resultColor = theme.textColor;
          resultIcon = Icons.question_mark;
      }
    } catch (e) {
      print('Error setting result appearance: $e');
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: theme.boardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SafeArea(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: resultColor.withOpacity(0.2),
            child: Icon(
              resultIcon,
              color: resultColor,
            ),
          ),
          title: Text(
            result,
            style: theme.bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: resultColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: theme.bodyStyle.copyWith(
                  fontSize: 12,
                  color: theme.textColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    _getGameModeIcon(gameMode),
                    size: 12,
                    color: theme.textColor.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getGameModeLabel(gameMode),
                    style: theme.bodyStyle.copyWith(
                      fontSize: 12,
                      color: theme.textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'X: $xScore',
                style: theme.bodyStyle.copyWith(
                  color: theme.xColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'O: $oScore',
                style: theme.bodyStyle.copyWith(
                  color: theme.oColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getGameModeIcon(String gameMode) {
    switch (gameMode) {
      case 'playerVsPlayer':
        return FontAwesomeIcons.userFriends;
      case 'easyAI':
      case 'mediumAI':
      case 'hardAI':
        return FontAwesomeIcons.robot;
      default:
        return Icons.gamepad;
    }
  }

  String _getGameModeLabel(String gameMode) {
    switch (gameMode) {
      case 'playerVsPlayer':
        return 'Player vs Player';
      case 'easyAI':
        return 'Easy AI';
      case 'mediumAI':
        return 'Medium AI';
      case 'hardAI':
        return 'Hard AI';
      default:
        return 'Unknown Mode';
    }
  }

  void _showClearHistoryDialog(
      BuildContext context, GameProvider gameProvider, GameTheme theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.boardColor,
        title: Text(
          'Clear History',
          style: theme.titleStyle.copyWith(fontSize: 20),
        ),
        content: Text(
          'Are you sure you want to clear all game history?',
          style: theme.bodyStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              SoundUtils.playMenuSound(
                haptic: gameProvider.hapticEnabled,
                soundEnabled: gameProvider.soundEnabled,
              );
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.textColor),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              SoundUtils.playMenuSound(
                haptic: gameProvider.hapticEnabled,
                soundEnabled: gameProvider.soundEnabled,
              );
              gameProvider.clearGameHistory();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
