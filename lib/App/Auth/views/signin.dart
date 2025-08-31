import 'package:NoblePay/App/Auth/views/forgetpassword.dart';
import 'package:NoblePay/App/Auth/views/signup_one.dart';
import 'package:NoblePay/App/Home/Views/entry.dart';
import 'package:NoblePay/App/Home/Views/mainhome.dart';
import 'package:NoblePay/App/widgets/button.dart';
import 'package:NoblePay/App/widgets/formfield.dart';
import 'package:NoblePay/App/widgets/gradienttext.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  bool _isAuthenticating = false;
  String _authStatus = '';

  Future<void> _authenticateWithBiometrics() async {
    setState(() {
      _isAuthenticating = true;
      _authStatus = 'Authenticating...';
    });

    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isAuthenticated = false;

      if (canCheckBiometrics) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to login',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
      }

      if (isAuthenticated) {
        setState(() {
          _authStatus = 'Authentication Successful';
        });
        // Call login or navigate to home screen
        print("Authenticated successfully");
      } else {
        setState(() {
          _authStatus = 'Authentication Failed';
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _authStatus = 'Error: ${e.message}';
      });
      print(e);
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                GradientText(text: "Sign In", fontSize: 39),
                CustomText(
                  title: "Please enter your details to continue",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  title: 'Email',
                  hintText: "Enter your email",
                  controller: emailController,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  title: 'Password',
                  hintText: "Enter your password",
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Nav.push(context, Forgetpassword());
                    },
                    child: CustomText(
                      title: "Forgot Password?",
                      fontSize: 14,
                      color: Colors.redAccent,
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                // Fingerprint icon button
                GestureDetector(
                  onTap: _isAuthenticating ? null : _authenticateWithBiometrics,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _isAuthenticating
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Icon(
                            Icons.fingerprint,
                            color: Colors.white,
                            size: 32,
                          ),
                  ),
                ),

                const SizedBox(height: 8),

                // Authentication status text
                if (_authStatus.isNotEmpty)
                  Text(
                    _authStatus,
                    style: TextStyle(
                      color: _authStatus.contains('Successful')
                          ? Colors.green
                          : Colors.red,
                      fontSize: 14,
                    ),
                  ),

                const SizedBox(height: 40),

                CustomButton(
                  text: "Sign In",
                  onPressed: () {
                    Nav.push(context, HomePage());
                  },
                ),
                const SizedBox(height: 40),

                GestureDetector(
                  onTap: () {
                    Nav.push(context, Signup_one());
                  },
                  child: Center(
                    child: GradientText(text: "Sign Up", fontSize: 26),
                  ),
                ),
                const SizedBox(height: 8),

                Center(
                  child: Text(
                    "By using this app you agree with our Terms of Use and Privacy Policy.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
