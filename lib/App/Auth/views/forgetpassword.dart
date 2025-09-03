import 'package:NoblePay/App/Auth/views/verifyreset.dart';
import 'package:NoblePay/App/widgets/Ordivider.dart';
import 'package:NoblePay/App/widgets/button.dart';
import 'package:NoblePay/App/widgets/formfield.dart';
import 'package:NoblePay/App/widgets/gradienttext.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/pagewrapper.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
        
                  const CustomTextFormField(
                    title: "Phone number",
                    hintText: "Enter your phone number",
                  ),
        
                  const SizedBox(height: 30),
        
                  const OrDivider(),
        
                  const SizedBox(height: 30),
        
                  const CustomTextFormField(
                    title: "Email address",
                    hintText: "Mackingsley@gmail.com",
                  ),
        
                  const SizedBox(height: 200),
        
                  CustomButton(
                    text: "Continue",
                    onPressed: () {
                      Nav.push(context, VerifyReset());
                    },
                  ),
        
                  const SizedBox(height: 30),
        
                  CustomButton(
                    text: "Cancel",
                    outlined: true,
                    onPressed: () {},
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
