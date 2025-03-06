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

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.buttonColor,
          labelColor: theme.buttonColor,
          unselectedLabelColor: theme.textColor.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Game', icon: Icon(Icons.gamepad)),
            Tab(text: 'Settings', icon: Icon(Icons.settings)),
          ],
          onTap: (_) {
            SoundUtils.playMenuSound(
              haptic: gameProvider.hapticEnabled,
              soundEnabled: gameProvider.soundEnabled,
            );
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGameTab(gameProvider, theme),
          _buildSettingsTab(theme),
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

            // Game mode indicator
            _buildGameModeIndicator(gameProvider, theme),
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
        modeText = 'Player vs Player';
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
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.boardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            modeIcon,
            size: 16,
            color: theme.buttonColor,
          ),
          const SizedBox(width: 8),
          Text(
            modeText,
            style: theme.bodyStyle.copyWith(
              color: theme.buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
