import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/log-in', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kost",
              style: primaryColorText.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Tiara Amarta",
              style: darkText.copyWith(fontSize: 20, fontWeight: regular),
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
    );
  }
}
