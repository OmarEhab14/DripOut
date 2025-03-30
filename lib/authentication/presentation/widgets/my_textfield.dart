import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

class MyTextField extends StatefulWidget {
  final String? hintText;
  final bool isPasswordField;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;

  const MyTextField({
    super.key,
    this.hintText,
    this.isPasswordField = false,
    this.controller,
    this.focusNode,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.primarySwatch[400]),
        suffixIcon: widget.isPasswordField
            ? (_isObsecure
                ? myIconButton(const Icon(Icons.visibility_off))
                : myIconButton(const Icon(Icons.visibility)))
            : null,
      ),
      obscureText: widget.isPasswordField ? _isObsecure : false,
    );
  }

  void toggleIsObsecure() {
    setState(() {
      _isObsecure = !_isObsecure;
    });
  }

  Widget myIconButton(Icon icon) {
    return IconButton(
        onPressed: () {
          toggleIsObsecure();
        },
        icon: icon);
  }
}
