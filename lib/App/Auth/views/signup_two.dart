import 'package:NoblePay/App/Auth/views/verification.dart';
import 'package:NoblePay/App/widgets/button.dart';
import 'package:NoblePay/App/widgets/formfield.dart';
import 'package:NoblePay/App/widgets/gradienttext.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/pagewrapper.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Signup_two extends StatefulWidget {
  const Signup_two({super.key});

  @override
  State<Signup_two> createState() => _Signup_twoState();
}

class _Signup_twoState extends State<Signup_two> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageWrapper(
        child: SingleChildScrollView(
          child: Padding(
                      padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 30.0,
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                // Step indicator at top right
        Align(
          alignment: Alignment.topRight,
          child: Text(
            "Step 2 of 2",
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
        
            CustomTextFormField(title: "First Name", hintText: "Mac kingsley"),
        
                const SizedBox(height: 10),
        
                CustomTextFormField(title: "Last Name", hintText: "Mac kingsley"),
        
                const SizedBox(height: 10),
        
                CustomTextFormField(title: "Username", hintText: "Mac kingsley"),
        
                const SizedBox(height: 10),
        
                CustomTextFormField(
                  title: "Email",
                  hintText: "01.01.0000",  
                ),
        
                 const SizedBox(height: 10),
        
                 CustomTextFormField(title: "Phone number", hintText: "8111111111"),
        
                  const SizedBox(height: 10),
        
             CustomTextFormField(title: "Street Address", hintText: "Moscow GP 2030"),
        
                const SizedBox(height: 10),
        
            CustomTextFormField(title: "City", hintText: "Moscow GP 2030"),
        
                const SizedBox(height: 10),
        
        CustomTextFormField(title: "Country", hintText: "Moscow GP 2030"),
        
                const SizedBox(height: 10),
                
               CustomTextFormField(title: "Postal Code", hintText: "Moscow GP 2030"),
        
                const SizedBox(height: 10),
        
            
        
              CustomTextFormField(
                  title: "Password",
                  hintText: "01.01.0000",  
                  isPassword: true,
                ),
        
        
         const SizedBox(height: 10),
        
             CustomTextFormField(
                  title: "Confirm Password",
                  hintText: "01.01.0000", 
                  isPassword: true, 
                ),
                
                 const SizedBox(height: 10),
        
                                 const SizedBox(height: 30),
        
                // Already registered text
        Center(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.nunito(
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
        
        
        const SizedBox(height: 10),
        
        
                CustomButton(text: "Sign Up", onPressed: () {
                  Nav.push(context, const Verification());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}