import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 52.54,
    this.borderRadius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.95,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFCC204A), // Red (left)
              Color(0xFFFD4E25), // Orange (right)
            ],
            stops: [0.19, 18], // more reddish, less orange
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              blurRadius: 12,
              offset: Offset(0, 6), // shadow goes downward
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}
