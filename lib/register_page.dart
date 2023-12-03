import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/login_page.dart';
import 'package:tiaraamarta_mobile/providers/user_provider.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final TextEditingController fullNameController =
        TextEditingController(text: '');

    final TextEditingController usernameController =
        TextEditingController(text: '');

    final TextEditingController passwordController =
        TextEditingController(text: '');

    bool isLoading = false;
    Future<void> handleRegister() async {
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      print("WKWKWK");
      if (await userProvider.register(
          fullname: fullNameController.text,
          username: usernameController.text,
          password: passwordController.text)) {
        print("WKWKWK");
        if (await userProvider.login(
            username: usernameController.text,
            password: passwordController.text)) {
          print("WKWKWK");
          navigator.pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          print(userProvider.errorMessage);
          scaffoldMessenger.removeCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                userProvider.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        print(userProvider.errorMessage);
        scaffoldMessenger.removeCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              userProvider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget inputFullName() {
      return CustomTextFormField(
        icon: Icon(
          Icons.person_rounded,
          color: primaryColor,
        ),
        hintText: 'Your Full Name',
        controller: fullNameController,
        radiusBorder: defaultRadius,
      );
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
        buttonText: "Register",
        widthButton: double.infinity,
        heightButton: 50,
        onPressed: () {
          handleRegister();
        },
        isLoading: isLoading,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            Text(
              "Register",
              style:
                  primaryColorText.copyWith(fontSize: 24, fontWeight: semibold),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Full Name",
              style: darkText.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            inputFullName(),
            const SizedBox(
              height: 20,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: greyText.copyWith(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Text(
                    "Login",
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
