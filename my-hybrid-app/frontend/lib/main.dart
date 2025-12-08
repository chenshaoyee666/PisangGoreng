import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'utils/app_theme.dart';
import 'utils/app_state.dart';

void main() {
  runApp(const SmartBiteApp());
}

class SmartBiteApp extends StatelessWidget {
  const SmartBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'SmartBite',
        theme: AppTheme.lightTheme,
        home: const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

