
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noblepay/App/Auth/views/scrolls.dart';
import 'package:noblepay/App/widgets/button.dart';
import 'package:noblepay/App/widgets/navigator.dart';
import 'package:noblepay/App/widgets/text.dart';



class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, // transparent so background shows
    statusBarIconBrightness: Brightness.dark, // dark icons
    statusBarBrightness: Brightness.light, // for iOS
  ));

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [

          
          // Positioned.fill(

          //   child: SvgPicture.asset(
          //     'assets/svg/ol1.svg', // replace with your background SVG path
          //     fit: BoxFit.fill,
          //     width: 200,
          //     height: 100,
          //   ),
          // ),


          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/logo.svg', 
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(height: 40),
SvgPicture.asset(
  'assets/svg/wallet.svg', 
  width: MediaQuery.of(context).size.width * 0.9, // almost full width
  height: 300, // taller height
),

                    const SizedBox(height: 40),
                    CustomText(
                      title: "Transfer money abroad quickly and at a low cost with our great rates",
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "Get Started",
                      onPressed: () {
                        Nav.push(context, const Scrolls());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}