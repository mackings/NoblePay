import 'package:NoblePay/App/Auth/views/signup_two.dart';
import 'package:NoblePay/App/widgets/button.dart';
import 'package:NoblePay/App/widgets/formfield.dart';
import 'package:NoblePay/App/widgets/gradienttext.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';




class Signup_one extends StatefulWidget {
  const Signup_one({super.key});

  @override
  State<Signup_one> createState() => _Signup_oneState();
}

class _Signup_oneState extends State<Signup_one> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Step indicator at top right
Align(
  alignment: Alignment.topRight,
  child: Text(
    "Step 1 of 2",
    style: GoogleFonts.nunito(
      color: Colors.red,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                const SizedBox(height: 40),

                GradientText(text: "Sign up", fontSize: 30),
                CustomText(
                  title: "Please enter your details to continue",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),

                const SizedBox(height: 30),

                CustomTextFormField(title: "Full Name", hintText: "Mac kingsley"),

                const SizedBox(height: 20),

                CustomTextFormField(
                  title: "Date of Birth",
                  hintText: "01.01.0000",
                  isDate: true,
                ),

                const SizedBox(height: 60),

                // Already registered text
Center(
  child: RichText(
    text: TextSpan(
      style: GoogleFonts.poppins(  
        fontSize: 14,
        color: Colors.grey[700],
      ),
      children: [
        TextSpan(
          text: "Already registered? ",
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: "Login",
          style: GoogleFonts.nunito(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Navigate to login screen
            },
        ),
      ],
    ),
  ),
),


                const SizedBox(height: 30),

                CustomButton(text: "Next", onPressed: () {
                  Nav.push(context, const Signup_two());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
