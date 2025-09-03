import 'package:noblepay/App/Auth/views/verification.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/formfield.dart';
import 'package:noblepay/App/widgets/gradienttext.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/pagewrapper.dart';
import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup_two extends StatefulWidget {
  final String fullname;
  final String dob;

  const Signup_two({super.key, required this.fullname, required this.dob});

  @override
  State<Signup_two> createState() => _Signup_twoState();
}

class _Signup_twoState extends State<Signup_two> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController countryController;
  late TextEditingController postalController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    postalController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

 
    print("From Page 1 => Fullname: ${widget.fullname}, DOB: ${widget.dob}");
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    countryController.dispose();
    postalController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 30.0,
            ),
            child: Column(
              children: [
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

                CustomTextFormField(
                  title: "Username",
                  hintText: "Mac kingsley",
                  controller: usernameController,
                ),

                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Email",
                  hintText: "example@email.com",
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Phone number",
                  hintText: "8111111111",
                  controller: phoneController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Street Address",
                  hintText: "Moscow GP 2030",
                  controller: streetController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "City",
                  hintText: "Moscow GP 2030",
                  controller: cityController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Country",
                  hintText: "Moscow GP 2030",
                  controller: countryController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Postal Code",
                  hintText: "2030",
                  controller: postalController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Password",
                  hintText: "********",
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Confirm Password",
                  hintText: "********",
                  isPassword: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    // Example: Collect all entered data
                    print("Fullname (from Page 1): ${widget.fullname}");
                    print("DOB (from Page 1): ${widget.dob}");
                    print("Email: ${emailController.text}");

                    Nav.push(context, const Verification());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
