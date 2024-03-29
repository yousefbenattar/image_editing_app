import 'package:flutter/material.dart';

import '../model/text_info.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key, required this.textInfo});
  final TextInfo textInfo;
  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
        color: textInfo.color,
      ),
    );
  }
}
