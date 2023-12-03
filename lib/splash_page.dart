import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';

import '../providers/user_provider.dart';
import '../services/user_service.dart';

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
    final navigator = Navigator.of(context);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();
    if (token == null) {
      await navigator.pushNamedAndRemoveUntil('/log-in', (route) => false);
    } else {
      if (await userProvider.getUser(token: token)) {
        // Get Data User
        await navigator.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        await navigator.pushNamedAndRemoveUntil('/log-in', (route) => false);
      }
    }
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
