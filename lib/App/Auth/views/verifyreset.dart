import 'package:noblepay/App/Auth/views/resetpassword.dart';
import 'package:noblepay/App/Auth/views/verification.dart';
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

class VerifyReset extends StatefulWidget {
  const VerifyReset({super.key});

  @override
  State<VerifyReset> createState() => _VerifyResetState();
}

class _VerifyResetState extends State<VerifyReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            /// Background SVG
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/svg/ol1.svg",
                fit: BoxFit.contain,
              ),
            ),

            /// Foreground Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 30.0,
                ),
                child: Column(
                  children: [
                    GradientText(text: "Enter verification code", fontSize: 30),

                    CustomText(
                      title: "We have sent an OTP to your mail or Phone number",
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

                    const SizedBox(height: 20),

                    CustomButton(
                      text: "Verify Now",
                      onPressed: () {
                        Nav.push(context, const ResetPassword());
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
