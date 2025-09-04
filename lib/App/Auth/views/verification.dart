import 'package:noblepay/App/Auth/Api/Authservice.dart';
import 'package:noblepay/App/Auth/views/signin.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/loader.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/pagewrapper.dart';
import 'package:noblepay/App/widgets/pinfields.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String otp = "";
  bool isLoading = false;

  Future<void> _verifyOtp() async {
    if (otp.isEmpty || otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the 6-digit OTP")),
      );
      return;
    }

    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("user_email");
    final phone = prefs.getString("user_phone");

    final api = ApiService();
    final result = await api.verifyRegistration(
      email: email,
      phoneNumber: phone,
      otp: otp,
    );

    setState(() => isLoading = false);

    if (result["isSuccess"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Verification successful")),
      );

      // ✅ Navigate to next screen (replace with your Home/Dashboard)
      Nav.pushReplacement(context, const Signin());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Verification failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageWrapper(
          child: SingleChildScrollView(
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
                  const SizedBox(height: 30),

                  PinCodeInput(
                    onCompleted: (pin) {
                      setState(() => otp = pin);
                      print("Entered PIN: $pin");
                    },
                    length: 6,
                  ),

                  const SizedBox(height: 370),

                  CustomButton(text: "Verify Now", onPressed: _verifyOtp),

                  const SizedBox(height: 30),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        children: [
                          const TextSpan(text: "Didn't receive the OTP? "),
                          TextSpan(
                            text: "Resend",
                            style: GoogleFonts.nunito(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final email = prefs.getString("user_email");

                                if (email == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "No email found. Please register again.",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final api = ApiService();
                                final result = await api
                                    .resendVerificationEmail(email);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result["message"] ??
                                          (result["isSuccess"] == true
                                              ? "Verification email resent!"
                                              : "Failed to resend email"),
                                    ),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "By verifying you agree with our Terms of Use and Privacy Policy.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
