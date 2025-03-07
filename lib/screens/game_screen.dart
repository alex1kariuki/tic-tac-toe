import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/game_model.dart';
import '../models/game_provider.dart';
import '../utils/theme_utils.dart';
import '../utils/sound_utils.dart';
import '../widgets/game_board.dart';
import '../widgets/score_board.dart';
import '../widgets/settings_panel.dart';
import 'history_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final theme = ThemeUtils.getTheme(gameProvider.theme);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: theme.titleStyle,
        ),
        backgroundColor: theme.boardColor,
        foregroundColor: theme.textColor,
        actions: [
          _buildGameModeIndicator(gameProvider, theme),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              SoundUtils.playMenuSound(
                haptic: gameProvider.hapticEnabled,
                soundEnabled: gameProvider.soundEnabled,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildGameTab(gameProvider, theme),
          _buildSettingsTab(theme),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          SoundUtils.playMenuSound(
            haptic: gameProvider.hapticEnabled,
            soundEnabled: gameProvider.soundEnabled,
          );
        },
        backgroundColor: theme.boardColor,
        selectedItemColor: theme.buttonColor,
        unselectedItemColor: theme.textColor.withOpacity(0.7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildGameTab(GameProvider gameProvider, GameTheme theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Score board
            const ScoreBoard(),

            // Game board
            const GameBoard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab(GameTheme theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: const SettingsPanel(),
    );
  }

  Widget _buildGameModeIndicator(GameProvider gameProvider, GameTheme theme) {
    String modeText;
    IconData modeIcon;

    switch (gameProvider.gameModel.gameMode) {
      case GameMode.playerVsPlayer:
        modeText = 'PvP';
        modeIcon = Icons.people;
        break;
      case GameMode.easyAI:
        modeText = 'Easy AI';
        modeIcon = Icons.smart_toy;
        break;
      case GameMode.mediumAI:
        modeText = 'Medium AI';
        modeIcon = Icons.smart_toy;
        break;
      case GameMode.hardAI:
        modeText = 'Hard AI';
        modeIcon = Icons.smart_toy;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.buttonColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            modeIcon,
            size: 16,
            color: theme.buttonColor,
          ),
          const SizedBox(width: 4),
          Text(
            modeText,
            style: theme.bodyStyle.copyWith(
              color: theme.buttonColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
