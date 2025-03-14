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
      onTap: () {
        try {
          // Add safety check before executing onTap
          if (onTap != null) {
            onTap();
          }
        } catch (e) {
          print('Error handling tap on cell [$row,$col]: $e');
        }
      },
      child: Container(
        decoration: theme.cellDecoration,
        child: Center(
          child: _buildPlayerSymbol(
              player, theme, cellSize, gameProvider.gameModel.playerSymbol),
        ),
      ),
    );
  }

  Widget _buildPlayerSymbol(Player player, GameTheme theme, double cellSize,
      PlayerSymbol symbolType) {
    try {
      // Add null check for player
      if (player == null) {
        return const SizedBox.shrink();
      }

      switch (player) {
        case Player.X:
          return _buildXSymbol(theme, cellSize, symbolType);
        case Player.O:
          return _buildOSymbol(theme, cellSize, symbolType);
        case Player.none:
          return const SizedBox.shrink();
      }
    } catch (e) {
      print('Error building player symbol: $e');
      return const SizedBox.shrink();
    }

    // Fallback return for safety
    return const SizedBox.shrink();
  }

  Widget _buildXSymbol(
      GameTheme theme, double cellSize, PlayerSymbol symbolType) {
    switch (symbolType) {
      case PlayerSymbol.classic:
        return _buildClassicX(theme, cellSize);
      case PlayerSymbol.heart:
        return _buildHeartX(theme, cellSize);
      case PlayerSymbol.star:
        return _buildStarX(theme, cellSize);
      case PlayerSymbol.diamond:
        return _buildDiamondX(theme, cellSize);
      default:
        return _buildClassicX(theme, cellSize);
    }
  }

  Widget _buildOSymbol(
      GameTheme theme, double cellSize, PlayerSymbol symbolType) {
    switch (symbolType) {
      case PlayerSymbol.classic:
        return _buildClassicO(theme, cellSize);
      case PlayerSymbol.heart:
        return _buildHeartO(theme, cellSize);
      case PlayerSymbol.star:
        return _buildStarO(theme, cellSize);
      case PlayerSymbol.diamond:
        return _buildDiamondO(theme, cellSize);
      default:
        return _buildClassicO(theme, cellSize);
    }
  }

  // Classic X symbol (two crossed lines)
  Widget _buildClassicX(GameTheme theme, double cellSize) {
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

  // Classic O symbol (circle)
  Widget _buildClassicO(GameTheme theme, double cellSize) {
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

  // Heart X symbol
  Widget _buildHeartX(GameTheme theme, double cellSize) {
    final size = cellSize * 0.7;

    return Icon(
      Icons.favorite,
      size: size,
      color: theme.xColor,
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  // Heart O symbol
  Widget _buildHeartO(GameTheme theme, double cellSize) {
    final size = cellSize * 0.7;

    return Icon(
      Icons.favorite_border,
      size: size,
      color: theme.oColor,
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  // Star X symbol
  Widget _buildStarX(GameTheme theme, double cellSize) {
    final size = cellSize * 0.7;

    return Icon(
      Icons.star,
      size: size,
      color: theme.xColor,
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  // Star O symbol
  Widget _buildStarO(GameTheme theme, double cellSize) {
    final size = cellSize * 0.7;

    return Icon(
      Icons.star_border,
      size: size,
      color: theme.oColor,
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  // Diamond X symbol
  Widget _buildDiamondX(GameTheme theme, double cellSize) {
    final size = cellSize * 0.7;

    return Icon(
      Icons.diamond,
      size: size,
      color: theme.xColor,
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }

  // Diamond O symbol
  Widget _buildDiamondO(GameTheme theme, double cellSize) {
    final size = cellSize * 0.7;

    return Icon(
      Icons.diamond_outlined,
      size: size,
      color: theme.oColor,
    ).animate().scale(
          duration: 300.ms,
          curve: Curves.elasticOut,
        );
  }
}
