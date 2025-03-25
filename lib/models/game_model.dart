import 'dart:math';
import 'dart:async';

enum Player { X, O, none }

enum GameMode { playerVsPlayer, easyAI, mediumAI, hardAI }

enum GameState { playing, draw, xWon, oWon }

enum PlayerSymbol { classic, heart, star, diamond }

class GameModel {
  // Game board represented as a 3x3 grid
  List<List<Player>> board = List.generate(
    3,
    (_) => List.generate(3, (_) => Player.none),
  );

  // Current player
  Player currentPlayer = Player.X;

  // Game mode
  GameMode gameMode = GameMode.playerVsPlayer;

  // Game state
  GameState gameState = GameState.playing;

  // Player symbols
  PlayerSymbol playerSymbol = PlayerSymbol.classic;

  // Move history for undo functionality
  List<Map<String, dynamic>> moveHistory = [];

  // Scores
  int xScore = 0;
  int oScore = 0;
  int draws = 0;

  // Reset the game board
  void resetBoard() {
    board = List.generate(
      3,
      (_) => List.generate(3, (_) => Player.none),
    );
    currentPlayer = Player.X;
    gameState = GameState.playing;
    moveHistory.clear();
  }

  // Reset scores
  void resetScores() {
    xScore = 0;
    oScore = 0;
    draws = 0;
  }

  // Make a move
  bool makeMove(int row, int col) {
    // Check for valid indices to prevent crashes
    if (row < 0 || row >= 3 || col < 0 || col >= 3) {
      return false;
    }

    // Check if the cell is empty and the game is still playing
    if (board[row][col] == Player.none && gameState == GameState.playing) {
      // Record move for history
      moveHistory.add({
        'row': row,
        'col': col,
        'player': currentPlayer,
      });

      // Make the move
      board[row][col] = currentPlayer;

      // Check for win or draw
      checkGameState();

      // Switch player if game is still playing
      if (gameState == GameState.playing) {
        currentPlayer = (currentPlayer == Player.X) ? Player.O : Player.X;

        // If playing against AI and it's AI's turn
        if (gameMode != GameMode.playerVsPlayer && currentPlayer == Player.O) {
          // Directly call AI move with no delay
          makeAIMove();
        }
      } else {
        // Update scores
        updateScores();
      }

      return true;
    }
    return false;
  }

  // Undo the last move
  bool undoMove() {
    if (moveHistory.isEmpty) return false;

    // If playing against AI, need to undo both player and AI moves
    if (gameMode != GameMode.playerVsPlayer) {
      // If the last move was by AI, undo both player and AI moves
      if (moveHistory.last['player'] == Player.O) {
        // Undo AI move
        final aiMove = moveHistory.removeLast();
        board[aiMove['row']][aiMove['col']] = Player.none;

        // Undo player move if there's any
        if (moveHistory.isNotEmpty) {
          final playerMove = moveHistory.removeLast();
          board[playerMove['row']][playerMove['col']] = Player.none;
        }
      } else {
        // If the last move was by player, just undo that
        final playerMove = moveHistory.removeLast();
        board[playerMove['row']][playerMove['col']] = Player.none;
      }
    } else {
      // In player vs player, just undo the last move
      final lastMove = moveHistory.removeLast();
      board[lastMove['row']][lastMove['col']] = Player.none;
      currentPlayer = lastMove[
          'player']; // Switch back to the player who made the last move
    }

    // Reset game state to playing
    gameState = GameState.playing;

    return true;
  }

  // Check if the game is over (win or draw)
  void checkGameState() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != Player.none &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        gameState = (board[i][0] == Player.X) ? GameState.xWon : GameState.oWon;
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] != Player.none &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        gameState = (board[0][i] == Player.X) ? GameState.xWon : GameState.oWon;
        return;
      }
    }

    // Check diagonals
    if (board[0][0] != Player.none &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      gameState = (board[0][0] == Player.X) ? GameState.xWon : GameState.oWon;
      return;
    }

    if (board[0][2] != Player.none &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      gameState = (board[0][2] == Player.X) ? GameState.xWon : GameState.oWon;
      return;
    }

    // Check for draw
    bool isBoardFull = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == Player.none) {
          isBoardFull = false;
          break;
        }
      }
    }

    if (isBoardFull) {
      gameState = GameState.draw;
    }
  }

  // Update scores based on game state
  void updateScores() {
    switch (gameState) {
      case GameState.xWon:
        xScore++;
        break;
      case GameState.oWon:
        oScore++;
        break;
      case GameState.draw:
        draws++;
        break;
      default:
        break;
    }
  }

  // AI move logic
  void makeAIMove() {
    // Double-check that conditions are right for AI to move
    if (gameState != GameState.playing || currentPlayer != Player.O) {
      print('AI move attempted in invalid state');
      return;
    }

    try {
      switch (gameMode) {
        case GameMode.easyAI:
          _makeRandomMove();
          break;
        case GameMode.mediumAI:
          // 50% chance of making a smart move, 50% random
          if (Random().nextBool()) {
            _makeSmartMove();
          } else {
            _makeRandomMove();
          }
          break;
        case GameMode.hardAI:
          _makeSmartMove();
          break;
        default:
          // Handle the case where gameMode is not an AI mode
          print('Invalid game mode for AI move: $gameMode');
          break;
      }
    } catch (e) {
      print('Error in AI move: $e');
      // Fallback to random move if there's an error
      _makeRandomMove();
    }
  }

  // Make a random move for easy AI
  void _makeRandomMove() {
    List<List<int>> emptyCells = [];

    // Find all empty cells
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == Player.none) {
          emptyCells.add([i, j]);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final randomIndex = Random().nextInt(emptyCells.length);
      final randomMove = emptyCells[randomIndex];
      // Directly modify the board instead of calling makeMove to avoid recursion
      board[randomMove[0]][randomMove[1]] = Player.O;
      moveHistory.add({
        'row': randomMove[0],
        'col': randomMove[1],
        'player': Player.O,
      });

      // Check game state after AI move
      checkGameState();

      // If game continues, switch back to player X
      if (gameState == GameState.playing) {
        currentPlayer = Player.X;
      } else {
        // Update scores if game ended
        updateScores();
      }
    }
  }

  // Make a smart move for medium/hard AI
  void _makeSmartMove() {
    // First, check if AI can win in the next move
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == Player.none) {
          board[i][j] = Player.O;
          if (_checkWin(Player.O)) {
            // Just keep the move we made (no need to reset and call makeMove)
            moveHistory.add({
              'row': i,
              'col': j,
              'player': Player.O,
            });

            // Update game state
            gameState = GameState.oWon;
            updateScores();
            return;
          }
          board[i][j] = Player.none; // Reset for next check
        }
      }
    }

    // Second, check if player can win in the next move and block
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == Player.none) {
          board[i][j] = Player.X;
          if (_checkWin(Player.X)) {
            board[i][j] = Player.O; // Make AI's move directly
            moveHistory.add({
              'row': i,
              'col': j,
              'player': Player.O,
            });

            // Check game state after AI move
            checkGameState();

            // If game continues, switch back to player X
            if (gameState == GameState.playing) {
              currentPlayer = Player.X;
            } else {
              // Update scores if game ended
              updateScores();
            }
            return;
          }
          board[i][j] = Player.none; // Reset for next check
        }
      }
    }

    // Third, take center if available
    if (board[1][1] == Player.none) {
      board[1][1] = Player.O;
      moveHistory.add({
        'row': 1,
        'col': 1,
        'player': Player.O,
      });

      // Check game state after AI move
      checkGameState();

      // If game continues, switch back to player X
      if (gameState == GameState.playing) {
        currentPlayer = Player.X;
      } else {
        // Update scores if game ended
        updateScores();
      }
      return;
    }

    // Fourth, take corners if available
    List<List<int>> corners = [
      [0, 0],
      [0, 2],
      [2, 0],
      [2, 2]
    ];
    List<List<int>> availableCorners = [];

    for (var corner in corners) {
      if (board[corner[0]][corner[1]] == Player.none) {
        availableCorners.add(corner);
      }
    }

    if (availableCorners.isNotEmpty) {
      final randomCorner =
          availableCorners[Random().nextInt(availableCorners.length)];

      board[randomCorner[0]][randomCorner[1]] = Player.O;
      moveHistory.add({
        'row': randomCorner[0],
        'col': randomCorner[1],
        'player': Player.O,
      });

      // Check game state after AI move
      checkGameState();

      // If game continues, switch back to player X
      if (gameState == GameState.playing) {
        currentPlayer = Player.X;
      } else {
        // Update scores if game ended
        updateScores();
      }
      return;
    }

    // Finally, take any available edge
    List<List<int>> edges = [
      [0, 1],
      [1, 0],
      [1, 2],
      [2, 1]
    ];
    List<List<int>> availableEdges = [];

    for (var edge in edges) {
      if (board[edge[0]][edge[1]] == Player.none) {
        availableEdges.add(edge);
      }
    }

    if (availableEdges.isNotEmpty) {
      final randomEdge =
          availableEdges[Random().nextInt(availableEdges.length)];

      board[randomEdge[0]][randomEdge[1]] = Player.O;
      moveHistory.add({
        'row': randomEdge[0],
        'col': randomEdge[1],
        'player': Player.O,
      });

      // Check game state after AI move
      checkGameState();

      // If game continues, switch back to player X
      if (gameState == GameState.playing) {
        currentPlayer = Player.X;
      } else {
        // Update scores if game ended
        updateScores();
      }
      return;
    }

    // If we get here, just make a random move (should not happen)
    _makeRandomMove();
  }

  // Helper method to check if a player has won
  bool _checkWin(Player player) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player &&
          board[i][1] == player &&
          board[i][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == player &&
          board[1][i] == player &&
          board[2][i] == player) {
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] == player &&
        board[1][1] == player &&
        board[2][2] == player) {
      return true;
    }

    if (board[0][2] == player &&
        board[1][1] == player &&
        board[2][0] == player) {
      return true;
    }

    return false;
  }
}
