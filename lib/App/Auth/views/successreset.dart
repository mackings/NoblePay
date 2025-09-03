import 'package:NoblePay/App/Auth/views/signin.dart';
import 'package:NoblePay/App/widgets/Dialogs/successdialog.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/pagewrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessReset extends StatefulWidget {
  const SuccessReset({super.key});

  @override
  State<SuccessReset> createState() => _SuccessResetState();
}

class _SuccessResetState extends State<SuccessReset> {
  @override
  void initState() {
    super.initState();

    // Show dialog after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (_) => SuccessDialog(
          onPressed: () {
            Nav.pushReplacement(context, Signin());
          },
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
        child: Stack(
          fit: StackFit.expand,
          children: [SvgPicture.asset("assets/svg/bgimg.svg", fit: BoxFit.cover)],
        ),
      ),
    );
  }
}
