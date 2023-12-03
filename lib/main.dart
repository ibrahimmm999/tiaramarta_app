import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/home_page.dart';
import 'package:tiaraamarta_mobile/login_page.dart';
import 'package:tiaraamarta_mobile/providers/ayokebali_provider.dart';
import 'package:tiaraamarta_mobile/providers/room_provider.dart';
import 'package:tiaraamarta_mobile/providers/user_provider.dart';
import 'package:tiaraamarta_mobile/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => RoomProvider()),
        ChangeNotifierProvider(create: (context) => AyoKeBaliProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/log-in': (context) => const LoginPage(),
        },
      ),
    );
  }
}
