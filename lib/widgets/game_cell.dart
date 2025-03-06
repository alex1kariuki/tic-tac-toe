import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/game_model.dart';
import '../utils/theme_utils.dart';
import '../models/game_provider.dart';

class GameCell extends StatelessWidget {
  final int row;
  final int col;
  final Player player;
  final VoidCallback onTap;

  const GameCell({
    super.key,
    required this.row,
    required this.col,
    required this.player,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final theme = ThemeUtils.getTheme(gameProvider.theme);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: theme.cellDecoration,
        child: Center(
          child: _buildPlayerSymbol(player, theme),
        ),
      ),
    );
  }

  Widget _buildPlayerSymbol(Player player, GameTheme theme) {
    switch (player) {
      case Player.X:
        return _buildXSymbol(theme);
      case Player.O:
        return _buildOSymbol(theme);
      case Player.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildXSymbol(GameTheme theme) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 45 * 3.14159 / 180,
          child: Container(
            width: 10,
            height: 60,
            decoration: BoxDecoration(
              color: theme.xColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Transform.rotate(
          angle: -45 * 3.14159 / 180,
          child: Container(
            width: 10,
            height: 60,
            decoration: BoxDecoration(
              color: theme.xColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  Widget _buildOSymbol(GameTheme theme) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.oColor,
          width: 10,
        ),
      ),
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }
}
