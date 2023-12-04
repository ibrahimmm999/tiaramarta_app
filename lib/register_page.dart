import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/login_page.dart';
import 'package:tiaraamarta_mobile/providers/user_provider.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool isLoading = false;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final TextEditingController fullNameController =
        TextEditingController(text: '');

    final TextEditingController usernameController =
        TextEditingController(text: '');

    final TextEditingController passwordController =
        TextEditingController(text: '');

    Future<void> handleRegister() async {
      setState(() {
        isLoading = !isLoading;
      });
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      if (await userProvider.register(
          fullname: fullNameController.text,
          username: usernameController.text,
          password: passwordController.text)) {
        if (await userProvider.login(
            username: usernameController.text,
            password: passwordController.text)) {
          setState(() {
            isLoading = !isLoading;
          });
          navigator.pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          print(userProvider.errorMessage);
          setState(() {
            isLoading = !isLoading;
          });
          scaffoldMessenger.removeCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Username sudah ada",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        print(userProvider.errorMessage);
        scaffoldMessenger.removeCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Username sudah ada",
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
