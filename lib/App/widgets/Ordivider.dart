import 'package:noblepay/App/widgets/text.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final double thickness;
  final Color color;

  const OrDivider({
    Key? key,
    this.text = "Or",
    this.thickness = 1,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
            endIndent: 10,
          ),
        ),

        CustomText(title: text,color: color,fontSize: 14,),

        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
