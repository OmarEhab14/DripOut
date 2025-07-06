import 'package:flutter/material.dart';

class MyTextButton extends TextButton {
  MyTextButton({required super.onPressed, required String text, EdgeInsetsGeometry? padding})
      : super(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationThickness: 1.7,
            ),
          ),
          style: TextButton.styleFrom(
            padding: padding ?? EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        );
}
