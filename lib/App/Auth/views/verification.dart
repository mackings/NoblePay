import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/pagewrapper.dart';
import 'package:noblepay/App/widgets/pinfields.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';



class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
        child: Stack(
          children: [
            /// Background SVG
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/svg/ol1.svg",
                fit: BoxFit.contain, // or BoxFit.contain if you want
              ),
            ),
        
            /// Foreground Content
            SingleChildScrollView(
              child: Padding(
                          padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 80.0,
            ),
                child: Column(
                  children: [
                    GradientText(text: "Verification", fontSize: 30),
            
                    CustomText(
                      title: "Enter your code below",
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    const SizedBox(height: 20),
            
                    PinCodeInput(
                      onCompleted: (pin) {
                        print("Entered PIN: $pin");
                      },
                    ),
            
                    const SizedBox(height: 380),
            
                    // Already registered text
            
            Center(
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  children: [
                    TextSpan(text: "Didn't receive the OTP? "),
                    TextSpan(
                      text: "Resend",
                      style: GoogleFonts.nunito(
            color: Colors.red,
            fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Handle resend logic
            },
                    ),
                  ],
                ),
              ),
            ),
            
                    const SizedBox(height: 10),
            
                    CustomButton(
                      text: "Verify Now",
                      onPressed: () {
                        Nav.push(context, const Verification());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}