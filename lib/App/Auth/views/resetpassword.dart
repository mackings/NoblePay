import 'package:noblepay/App/Auth/views/successreset.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/formfield.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/pagewrapper.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Center(
            child: Column(
              children: [
                const GradientText(text: "Reset Your Password"),

                const CustomText(
                  title: "The password must be different than before",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),

                const SizedBox(height: 30),

                const CustomTextFormField(
                  title: "New password",
                  hintText: "Enter new password",
                  isPassword: true,
                ),

                const SizedBox(height: 30),

                const CustomTextFormField(
                  title: "Confirm password",
                  hintText: "Confirm new password",
                  isPassword: true,
                ),

                const SizedBox(height: 260),

                CustomButton(
                  text: "Continue",
                  onPressed: () {
                    Nav.push(context, SuccessReset());
                  },
                ),

                const SizedBox(height: 30),

                CustomButton(text: "Cancel", outlined: true, onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
