import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'models/game_provider.dart';
import 'screens/game_screen.dart';
import 'utils/sound_utils.dart';

void main() async {
  // Catch any Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('Flutter error caught: ${details.exception}');
  };

  // Catch any Dart errors that aren't caught by Flutter
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      // Set preferred orientations
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Preload sounds
      await SoundUtils.preloadSounds();

      runApp(const MyApp());
    } catch (e, stackTrace) {
      print('Error during initialization: $e');
      print('Stack trace: $stackTrace');
      // Still try to run the app even if initialization fails
      runApp(const MyApp());
    }
  }, (error, stackTrace) {
    print('Uncaught error: $error');
    print('Stack trace: $stackTrace');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return MaterialApp(
            title: 'Tic Tac Toe',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness:
                    gameProvider.theme == 'dark' || gameProvider.theme == 'neon'
                        ? Brightness.dark
                        : Brightness.light,
              ),
            ),
            home: const GameScreen(),
          );
        },
      ),
    );
  }
}
