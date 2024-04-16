import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeohaeng_ttukttak/di/setup_providers.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/auth_screen.dart';
import 'package:yeohaeng_ttukttak/theme.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ...globalProviders
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const materialTheme = MaterialTheme(TextTheme());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      title: 'Flutter Maps Demo',
      home: const AuthScreen(), // MapView 위젯 사용
    );
  }
}
