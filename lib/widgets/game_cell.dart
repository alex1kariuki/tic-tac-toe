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
    final size = MediaQuery.of(context).size;
    final cellSize =
        size.width > size.height ? size.height * 0.15 : size.width * 0.2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: theme.cellDecoration,
        child: Center(
          child: _buildPlayerSymbol(player, theme, cellSize),
        ),
      ),
    );
  }

  Widget _buildPlayerSymbol(Player player, GameTheme theme, double cellSize) {
    switch (player) {
      case Player.X:
        return _buildXSymbol(theme, cellSize);
      case Player.O:
        return _buildOSymbol(theme, cellSize);
      case Player.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildXSymbol(GameTheme theme, double cellSize) {
    final lineWidth = cellSize * 0.12;
    final lineHeight = cellSize * 0.75;

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 45 * 3.14159 / 180,
          child: Container(
            width: lineWidth,
            height: lineHeight,
            decoration: BoxDecoration(
              color: theme.xColor,
              borderRadius: BorderRadius.circular(lineWidth / 2),
            ),
          ),
        ),
        Transform.rotate(
          angle: -45 * 3.14159 / 180,
          child: Container(
            width: lineWidth,
            height: lineHeight,
            decoration: BoxDecoration(
              color: theme.xColor,
              borderRadius: BorderRadius.circular(lineWidth / 2),
            ),
          ),
        ),
      ],
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  Widget _buildOSymbol(GameTheme theme, double cellSize) {
    final size = cellSize * 0.75;
    final borderWidth = cellSize * 0.12;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.oColor,
          width: borderWidth,
        ),
      ),
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }
}
