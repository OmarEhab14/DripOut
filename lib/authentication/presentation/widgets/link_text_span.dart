import 'package:drip_out/common/helpers/navigation_target.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkTextSpan {
  static TextSpan build({
    required String text,
    required NavigationTarget target,
    required BuildContext context,
    bool isPushReplacement = false,
  }) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationThickness: 1.7,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () => _navigate(context, target, isPushReplacement),
    );
  }

  static void _navigate(
      BuildContext context, NavigationTarget target, isPushReplacement) {
    if (target.isUrl) {
      final Uri url = Uri.parse(target.value);
      launchUrl(url);
    } else {
      isPushReplacement
          ? Navigator.pushReplacementNamed(context, target.value)
          : Navigator.pushNamed(context, target.value);
    }
  }
}
