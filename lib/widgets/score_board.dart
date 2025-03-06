import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/game_provider.dart';
import '../utils/theme_utils.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final gameModel = gameProvider.gameModel;
    final theme = ThemeUtils.getTheme(gameProvider.theme);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Container(
      margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 8 : 16),
      padding: EdgeInsets.all(isSmallScreen ? 8 : 16),
      decoration: BoxDecoration(
        color: theme.boardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildScoreItem('X', gameModel.xScore, theme.xColor, theme, isSmallScreen),
          _buildScoreItem('Draws', gameModel.draws, theme.textColor, theme, isSmallScreen),
          _buildScoreItem('O', gameModel.oScore, theme.oColor, theme, isSmallScreen),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(
          begin: 0.2,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildScoreItem(
      String label, int score, Color color, GameTheme theme, bool isSmallScreen) {
    final itemSize = isSmallScreen ? 45.0 : 60.0;
    final fontSize = isSmallScreen ? 14.0 : 16.0;
    final scoreFontSize = isSmallScreen ? 18.0 : 20.0;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: theme.bodyStyle.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),
        Container(
          width: itemSize,
          height: itemSize,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              score.toString(),
              style: theme.scoreStyle.copyWith(
                color: color,
                fontSize: scoreFontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
