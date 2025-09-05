import 'package:noblepay/App/Auth/Api/Authservice.dart';
import 'package:noblepay/App/Auth/views/resetpassword.dart';
import 'package:noblepay/App/Auth/views/verifyreset.dart';
import 'package:noblepay/App/widgets/Ordivider.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/formfield.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/loader.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  Future<void> _forgotPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter your email")));
      return;
    }

    setState(() => isLoading = true);

    final api = ApiService();
    final result = await api.forgotPassword(email);

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result["message"] ?? "Request failed")),
    );

    if (result["isSuccess"] == true) {
      // ✅ Navigate to verify reset page if API success
      Nav.push(context, VerifyReset(email: email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 30.0,
              ),
              child: Center(
                child: Column(
                  children: [
                    const GradientText(text: "Forget Password"),

                    const CustomText(
                      title:
                          "Enter your phone number or email account to reset password",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),

                    const SizedBox(height: 30),

                    CustomTextFormField(
                      title: "Phone number",
                      hintText: "Enter your phone number",
                      controller: phoneController,
                    ),

                    const SizedBox(height: 30),

                    const OrDivider(),

                    const SizedBox(height: 30),

                    CustomTextFormField(
                      title: "Email address",
                      hintText: "mackingsley@gmail.com",
                      controller: emailController,
                    ),

                    const SizedBox(height: 200),

                    CustomButton(text: "Continue", onPressed: _forgotPassword),

                    const SizedBox(height: 30),

                    CustomButton(
                      text: "Cancel",
                      outlined: true,
                      onPressed: () {
                        Nav.push(
                          context,
                          VerifyReset(email: emailController.text),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
