import 'package:flutter/material.dart';
import 'package:healthforall/constants.dart';

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
