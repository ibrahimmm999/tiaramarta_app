import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/providers/user_provider.dart';
import 'package:tiaraamarta_mobile/services/user_service.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';
import 'package:tiaraamarta_mobile/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isLoading = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    Future<void> handleLogout() async {
      setState(() {
        isLoading = !isLoading;
      });
      final navigator = Navigator.of(context);
      print(userProvider.user);
      print("logout");
      await UserService().clearTokenPreference();
      setState(() {
        isLoading = !isLoading;
      });
      navigator.pushNamedAndRemoveUntil('/log-in', (route) => false);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 32,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Profile",
                    style: primaryColorText.copyWith(fontSize: 32),
                  )
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Text(
                "Full Name: ${userProvider.user.fullname}",
                style: darkText.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Username: ${userProvider.user.username}",
                style: darkText.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 80,
              ),
              CustomButton(
                isLoading: isLoading,
                buttonColor: Colors.red,
                buttonText: "Logout",
                onPressed: () {
                  handleLogout();
                },
                radiusButton: defaultRadius,
                widthButton: double.infinity,
                heightButton: 44,
              )
            ],
          ),
        ),
      ),
    );
  }
}
