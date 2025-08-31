import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double borderRadius;
  final bool outlined;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 52.54,
    this.borderRadius = 15,
    this.outlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? MediaQuery.of(context).size.width * 0.95;

    if (outlined) {
      // Outlined Gradient Button
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: buttonWidth,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFCC204A), Color(0xFFFD4E25)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            margin: const EdgeInsets.all(2), // border thickness
            decoration: BoxDecoration(
              color: Colors.white, // background of button
              borderRadius: BorderRadius.circular(borderRadius - 1),
            ),
            alignment: Alignment.center,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFCC204A), Color(0xFFFD4E25)],
              ).createShader(Rect.fromLTWH(0, 0, buttonWidth, height)),
              child: Text(
                text,
                style: GoogleFonts.nunitoSans(
                  color: Colors.white, // required for ShaderMask
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Filled Gradient Button (default)
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFCC204A), Color(0xFFFD4E25)],
            stops: [0.19, 0.8],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}
