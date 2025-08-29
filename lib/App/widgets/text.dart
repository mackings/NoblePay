import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final double letterSpacing;

  const CustomText({
    Key? key,
    required this.title,
    this.fontSize = 24,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black87,
    this.textAlign = TextAlign.center,
    this.letterSpacing = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.nunitoSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
