import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextType type;
  final Color? color;
  final bool alignCenter;

  const CustomText({
    super.key,
    required this.text,
    this.type = TextType.body,
    this.color,
    this.alignCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style;

    switch (type) {
      case TextType.title:
        style = TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black,
        );
        break;
      case TextType.subtitle:
        style = TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: color ?? Colors.grey,
        );
        break;
      case TextType.body:
        style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: color ?? Colors.black,
        );
        break;
    }

    return Text(
      text,
      style: style,
      textAlign: alignCenter ? TextAlign.center : null,
    );
  }
}

enum TextType { title, subtitle, body }
