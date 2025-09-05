import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noblepay/App/Auth/Api/Authservice.dart';
import 'package:noblepay/App/Home/Views/entry.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/loader.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/pagewrapper.dart';
import 'package:noblepay/App/widgets/pinfields.dart';
import 'package:noblepay/App/widgets/text.dart';

class Twofactor extends StatefulWidget {
  final String email;
  const Twofactor({super.key, required this.email});

  @override
  State<Twofactor> createState() => _TwofactorState();
}

class _TwofactorState extends State<Twofactor> {
  String otp = "";
  bool isLoading = false;

  Future<void> _verifyOtp() async {
    if (otp.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter the OTP")));
      return;
    }

    setState(() => isLoading = true);

    final api = ApiService();
    final result = await api.verifyLogin(email: widget.email, otp: otp);

    setState(() => isLoading = false);

    if (result["isSuccess"] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login verified ✅")));

      // ✅ Close modal and go to HomePage
      Navigator.pop(context); // close bottom sheet
      Nav.pushReplacement(context, HomePage());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Invalid OTP")),
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
                  GradientText(text: "2FA Verification", fontSize: 30),
                  CustomText(
                    title: "Enter your OTP below",
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  const SizedBox(height: 30),

                  PinCodeInput(
                    onCompleted: (pin) {
                      setState(() => otp = pin);
                      print("Entered OTP: $pin");
                    },
                    length: 6,
                  ),

                  const SizedBox(height: 110),

                  CustomButton(text: "Verify", onPressed: _verifyOtp),

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
                                final api = ApiService();
                                final result = await api
                                    .resendVerificationEmail(widget.email);

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
