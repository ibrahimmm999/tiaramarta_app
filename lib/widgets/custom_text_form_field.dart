import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomTextFormField extends StatefulWidget {
  final Icon? icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final double radiusBorder;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    this.icon,
    required this.radiusBorder,
    this.isPassword = false,
    this.hintText = '',
    required this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null; // Return null if the field is valid
      },
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: widget.isPassword ? isObscure : false,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        suffixIcon: Visibility(
          visible: widget.isPassword,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            child: isObscure
                ? Icon(
                    Icons.visibility_off,
                    color: grey,
                  )
                : Icon(
                    Icons.visibility,
                    color: primaryColor,
                  ),
          ),
        ),
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        hintStyle: greyText,
        focusColor: primaryColor,
        border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radiusBorder)),
            borderSide: BorderSide(color: grey)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radiusBorder),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}
