import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/providers/user_provider.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';
import 'package:tiaraamarta_mobile/register_page.dart';
import 'package:tiaraamarta_mobile/widgets/custom_button.dart';
import 'package:tiaraamarta_mobile/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isLoading = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');
    UserProvider userProvider = Provider.of<UserProvider>(context);

    Future<void> handleLogin() async {
      setState(() {
        isLoading = !isLoading;
      });
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      if (await userProvider.login(
          username: usernameController.text,
          password: passwordController.text)) {
        setState(() {
          isLoading = !isLoading;
        });
        navigator.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        setState(() {
          isLoading = !isLoading;
        });
        scaffoldMessenger.removeCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Username atau password salah",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget inputUsername() {
      return CustomTextFormField(
        icon: Icon(
          Icons.radio_button_checked_rounded,
          color: primaryColor,
        ),
        hintText: 'Your Username',
        controller: usernameController,
        radiusBorder: defaultRadius,
      );
    }

    Widget inputPassword() {
      return CustomTextFormField(
        icon: Icon(Icons.lock, color: primaryColor),
        controller: passwordController,
        hintText: 'Your Password',
        isPassword: true,
        radiusBorder: defaultRadius,
      );
    }

    Widget submitButton() {
      return CustomButton(
        radiusButton: defaultRadius,
        buttonColor: primaryColor,
        buttonText: "Login",
        widthButton: double.infinity,
        isLoading: isLoading,
        onPressed: () {
          handleLogin();
        },
        heightButton: 50,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            Text(
              "Login",
              style:
                  primaryColorText.copyWith(fontSize: 24, fontWeight: semibold),
            ),
            Text(
              "Register to Countinue",
              style: greyText.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              "Username",
              style: darkText.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            inputUsername(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Password",
              style: darkText.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            inputPassword(),
            const SizedBox(
              height: 30,
            ),
            submitButton(),
            const SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: greyText.copyWith(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: Text(
                    "Register",
                    style: secondaryColorText.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
