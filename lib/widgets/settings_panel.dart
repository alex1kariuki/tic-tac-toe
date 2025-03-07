import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/game_model.dart';
import '../models/game_provider.dart';
import '../utils/sound_utils.dart';
import '../utils/theme_utils.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final theme = ThemeUtils.getTheme(gameProvider.theme);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.boardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Game Settings',
            style: theme.titleStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),

          // Game mode selection
          Text(
            'Game Mode',
            style: theme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildGameModeSelector(gameProvider, theme),
          const SizedBox(height: 16),

          // Player symbol selection
          Text(
            'Player Symbols',
            style: theme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildPlayerSymbolSelector(gameProvider, theme),
          const SizedBox(height: 16),

          // Theme selection
          Text(
            'Theme',
            style: theme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildThemeSelector(gameProvider, theme),
          const SizedBox(height: 16),

          // Sound and haptic toggles
          Row(
            children: [
              Expanded(
                child: _buildToggleOption(
                  'Sound',
                  gameProvider.soundEnabled,
                  () {
                    gameProvider.toggleSound();
                    if (gameProvider.soundEnabled) {
                      SoundUtils.playMenuSound(
                        haptic: gameProvider.hapticEnabled,
                        soundEnabled: true,
                      );
                    }
                  },
                  theme,
                  icon: gameProvider.soundEnabled
                      ? Icons.volume_up
                      : Icons.volume_off,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildToggleOption(
                  'Haptic',
                  gameProvider.hapticEnabled,
                  () {
                    gameProvider.toggleHaptic();
                    if (gameProvider.soundEnabled) {
                      SoundUtils.playMenuSound(
                        haptic: gameProvider.hapticEnabled,
                        soundEnabled: gameProvider.soundEnabled,
                      );
                    }
                  },
                  theme,
                  icon: gameProvider.hapticEnabled
                      ? Icons.vibration
                      : Icons.do_not_disturb,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Reset scores button
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                SoundUtils.playMenuSound(
                  haptic: gameProvider.hapticEnabled,
                  soundEnabled: gameProvider.soundEnabled,
                );
                gameProvider.resetScores();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Scores'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.buttonColor,
                foregroundColor: theme.buttonTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModeSelector(GameProvider gameProvider, GameTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildGameModeOption(
            'Player vs Player',
            GameMode.playerVsPlayer,
            gameProvider,
            theme,
            icon: FontAwesomeIcons.userFriends,
          ),
          _buildDivider(theme),
          _buildGameModeOption(
            'Easy AI',
            GameMode.easyAI,
            gameProvider,
            theme,
            icon: FontAwesomeIcons.robot,
          ),
          _buildDivider(theme),
          _buildGameModeOption(
            'Medium AI',
            GameMode.mediumAI,
            gameProvider,
            theme,
            icon: FontAwesomeIcons.robot,
          ),
          _buildDivider(theme),
          _buildGameModeOption(
            'Hard AI',
            GameMode.hardAI,
            gameProvider,
            theme,
            icon: FontAwesomeIcons.robot,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSymbolSelector(
      GameProvider gameProvider, GameTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildPlayerSymbolOption(
            'Classic',
            PlayerSymbol.classic,
            gameProvider,
            theme,
            xIcon: Icons.close,
            oIcon: Icons.circle_outlined,
          ),
          _buildDivider(theme),
          _buildPlayerSymbolOption(
            'Hearts',
            PlayerSymbol.heart,
            gameProvider,
            theme,
            xIcon: Icons.favorite,
            oIcon: Icons.favorite_border,
          ),
          _buildDivider(theme),
          _buildPlayerSymbolOption(
            'Stars',
            PlayerSymbol.star,
            gameProvider,
            theme,
            xIcon: Icons.star,
            oIcon: Icons.star_border,
          ),
          _buildDivider(theme),
          _buildPlayerSymbolOption(
            'Diamonds',
            PlayerSymbol.diamond,
            gameProvider,
            theme,
            xIcon: Icons.diamond,
            oIcon: Icons.diamond_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSymbolOption(
    String label,
    PlayerSymbol symbol,
    GameProvider gameProvider,
    GameTheme theme, {
    required IconData xIcon,
    required IconData oIcon,
  }) {
    final isSelected = gameProvider.gameModel.playerSymbol == symbol;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          SoundUtils.playMenuSound(
            haptic: gameProvider.hapticEnabled,
            soundEnabled: gameProvider.soundEnabled,
          );
          gameProvider.setPlayerSymbol(symbol);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              xIcon,
              size: 16,
              color: theme.xColor,
            ),
            const SizedBox(width: 8),
            Icon(
              oIcon,
              size: 16,
              color: theme.oColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: theme.bodyStyle.copyWith(
                  color: isSelected ? theme.buttonColor : theme.textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.buttonColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameModeOption(
    String label,
    GameMode mode,
    GameProvider gameProvider,
    GameTheme theme, {
    IconData? icon,
  }) {
    final isSelected = gameProvider.gameModel.gameMode == mode;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          SoundUtils.playMenuSound(
            haptic: gameProvider.hapticEnabled,
            soundEnabled: gameProvider.soundEnabled,
          );
          gameProvider.setGameMode(mode);
          gameProvider.resetBoard();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              FaIcon(
                icon,
                size: 16,
                color: isSelected
                    ? theme.buttonColor
                    : theme.textColor.withOpacity(0.7),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                label,
                style: theme.bodyStyle.copyWith(
                  color: isSelected ? theme.buttonColor : theme.textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.buttonColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(GameProvider gameProvider, GameTheme theme) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          _buildThemeOption('classic', 'Classic', gameProvider, theme),
          _buildThemeOption('neon', 'Neon', gameProvider, theme),
          _buildThemeOption('minimalist', 'Minimal', gameProvider, theme),
          _buildThemeOption('dark', 'Dark', gameProvider, theme),
          _buildThemeOption('cosmic', 'Cosmic', gameProvider, theme),
          _buildThemeOption('retro', 'Retro', gameProvider, theme),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    String themeKey,
    String label,
    GameProvider gameProvider,
    GameTheme currentTheme,
  ) {
    final isSelected = gameProvider.theme == themeKey;
    final optionTheme = ThemeUtils.getTheme(themeKey);

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          SoundUtils.playMenuSound(
            haptic: gameProvider.hapticEnabled,
            soundEnabled: gameProvider.soundEnabled,
          );
          gameProvider.setTheme(themeKey);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: optionTheme.boardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? currentTheme.buttonColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: currentTheme.buttonColor.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: optionTheme.textColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption(
    String label,
    bool value,
    VoidCallback onToggle,
    GameTheme theme, {
    IconData? icon,
  }) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value ? theme.buttonColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: value
                    ? theme.buttonColor
                    : theme.textColor.withOpacity(0.7),
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: theme.bodyStyle.copyWith(
                color: value ? theme.buttonColor : theme.textColor,
                fontWeight: value ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(GameTheme theme) {
    return Container(
      height: 1,
      color: theme.gridLineColor.withOpacity(0.2),
    );
  }
}
