import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double heightButton;
  final double widthButton;
  final double radiusButton;
  final Color buttonColor;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.radiusButton,
    required this.buttonColor,
    required this.buttonText,
    required this.widthButton,
    required this.onPressed,
    required this.heightButton,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      height: heightButton,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusButton))),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: white,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Loading',
                    style: whiteText.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ],
              )
            : Text(
                buttonText,
                style: whiteText.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
