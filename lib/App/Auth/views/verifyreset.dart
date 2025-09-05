import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noblepay/App/Auth/Api/Authservice.dart';
import 'package:noblepay/App/Auth/views/successreset.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/formfield.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/loader.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/pinfields.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';



class VerifyReset extends StatefulWidget {
  final String email; 
  const VerifyReset({super.key, required this.email});

  @override
  State<VerifyReset> createState() => _VerifyResetState();
}

class _VerifyResetState extends State<VerifyReset> {
  String otp = "";
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _resetPassword() async {
    if (otp.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter OTP and new password")),
      );
      return;
    }

    setState(() => isLoading = true);

    final api = ApiService();

    // 🔑 Get userId from secure storage
    final userId = await _secureStorage.read(key: "userId");

    if (userId == null) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found, please login again")),
      );
      return;
    }

    final result = await api.resetPassword(
      userId: userId,
      passwordResetCode: otp,
      newPassword: passwordController.text,
    );

    setState(() => isLoading = false);

    if (result["isSuccess"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Password reset successful")),
      );
      Nav.push(context, const SuccessReset());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Password reset failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
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
                        title:
                            "We have sent an OTP to your mail or Phone number",
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      const SizedBox(height: 20),

                      PinCodeInput(
                        length: 6,
                        onCompleted: (pin) {
                          setState(() => otp = pin);
                        },
                      ),

                      const SizedBox(height: 40),

                      CustomTextFormField(
                        title: "Enter new Password",
                        hintText: "NewPassword@3u",
                        controller: passwordController,
                        isPassword: true,
                      ),

                      const SizedBox(height: 300),

                      CustomButton(
                        text: "Reset password",
                        onPressed: _resetPassword,
                      ),

                      const SizedBox(height: 20),

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
                                  ..onTap = () {
                                    // 🔄 Call forgotPassword again
                                    ApiService().forgotPassword(widget.email);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


