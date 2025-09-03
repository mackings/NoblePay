import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const GradientText({
    Key? key,
    required this.text,
    this.fontSize = 24,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFCC204A), // more reddish
          Color(0xFFFD4E25), // less orange
        ],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: GoogleFonts.nunitoSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white, // color is overridden by ShaderMask
        ),
      ),
    );
  }
}
