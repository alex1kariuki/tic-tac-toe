import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import '../models/game_model.dart';
import '../models/game_provider.dart';
import '../utils/sound_utils.dart';
import '../utils/theme_utils.dart';
import 'game_cell.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final gameModel = gameProvider.gameModel;
    final theme = ThemeUtils.getTheme(gameProvider.theme);
    final size = MediaQuery.of(context).size;
    final boardSize =
        size.width > size.height ? size.height * 0.7 : size.width * 0.85;

    // Check if game just ended and play appropriate sound
    if (gameModel.gameState != GameState.playing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (gameModel.gameState == GameState.xWon ||
            gameModel.gameState == GameState.oWon) {
          SoundUtils.playWinSound(
            haptic: gameProvider.hapticEnabled,
            soundEnabled: gameProvider.soundEnabled,
          );
          _confettiController.play();
        } else if (gameModel.gameState == GameState.draw) {
          SoundUtils.playDrawSound(
            haptic: gameProvider.hapticEnabled,
            soundEnabled: gameProvider.soundEnabled,
          );
        }
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Game status text
        _buildGameStatus(gameModel, theme),

        const SizedBox(height: 20),

        // Game board
        Stack(
          alignment: Alignment.center,
          children: [
            // Confetti effect for wins
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.2,
                colors: [theme.xColor, theme.oColor, theme.buttonColor],
              ),
            ),

            // Game board
            SizedBox(
              width: boardSize,
              height: boardSize,
              child: Container(
                decoration: theme.boardDecoration,
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.boardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        final row = index ~/ 3;
                        final col = index % 3;
                        return GameCell(
                          row: row,
                          col: col,
                          player: gameModel.board[row][col],
                          onTap: () => _handleCellTap(gameProvider, row, col),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ).animate().fade(duration: 500.ms).scale(
                begin: const Offset(0.8, 0.8),
                duration: 500.ms,
                curve: Curves.easeOutBack),
          ],
        ),

        const SizedBox(height: 20),

        // Game controls
        _buildGameControls(gameProvider, theme),
      ],
    );
  }

  Widget _buildGameStatus(GameModel gameModel, GameTheme theme) {
    String statusText;
    Color statusColor;

    switch (gameModel.gameState) {
      case GameState.playing:
        statusText =
            'Current Turn: ${gameModel.currentPlayer == Player.X ? 'X' : 'O'}';
        statusColor =
            gameModel.currentPlayer == Player.X ? theme.xColor : theme.oColor;
        break;
      case GameState.xWon:
        statusText = 'X Wins!';
        statusColor = theme.xColor;
        break;
      case GameState.oWon:
        statusText = 'O Wins!';
        statusColor = theme.oColor;
        break;
      case GameState.draw:
        statusText = 'Draw!';
        statusColor = theme.textColor;
        break;
    }

    return Text(
      statusText,
      style: theme.titleStyle.copyWith(
        color: statusColor,
        fontSize: 24,
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .fadeIn(
          duration: 300.ms,
        )
        .then(
          delay: 200.ms,
        )
        .shimmer(
          duration: 1200.ms,
          color: statusColor.withOpacity(0.7),
        );
  }

  Widget _buildGameControls(GameProvider gameProvider, GameTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Undo button
        ElevatedButton.icon(
          onPressed: gameProvider.gameModel.moveHistory.isEmpty
              ? null
              : () {
                  SoundUtils.playMenuSound(
                    haptic: gameProvider.hapticEnabled,
                    soundEnabled: gameProvider.soundEnabled,
                  );
                  gameProvider.undoMove();
                },
          icon: const Icon(Icons.undo),
          label: const Text('Undo'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.buttonColor,
            foregroundColor: theme.buttonTextColor,
            disabledBackgroundColor: theme.buttonColor.withOpacity(0.3),
            disabledForegroundColor: theme.buttonTextColor.withOpacity(0.3),
          ),
        ),

        // Reset button
        ElevatedButton.icon(
          onPressed: () {
            SoundUtils.playMenuSound(
              haptic: gameProvider.hapticEnabled,
              soundEnabled: gameProvider.soundEnabled,
            );
            gameProvider.resetBoard();
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Reset'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.buttonColor,
            foregroundColor: theme.buttonTextColor,
          ),
        ),
      ],
    );
  }

  void _handleCellTap(GameProvider gameProvider, int row, int col) {
    // If cell is already occupied or game is over, play error sound
    if (gameProvider.gameModel.board[row][col] != Player.none ||
        gameProvider.gameModel.gameState != GameState.playing) {
      SoundUtils.playErrorSound(
        haptic: gameProvider.hapticEnabled,
        soundEnabled: gameProvider.soundEnabled,
      );
      return;
    }

    // Play tap sound
    SoundUtils.playTapSound(
      haptic: gameProvider.hapticEnabled,
      soundEnabled: gameProvider.soundEnabled,
    );

    // Make the move
    gameProvider.makeMove(row, col);
  }
}
