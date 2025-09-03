import 'package:NoblePay/App/Home/Views/scanqr.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // increase height to allow QR button to float
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none, // allow drawing outside
        children: [
          // Background bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem(Icons.home, "Home", 0),
                  navItem(Icons.chat, "Chat", 1),
                  SizedBox(width: 60), // space for QR button
                  navItem(Icons.credit_card, "Card", 3),
                  navItem(Icons.settings, "Settings", 4),
                ],
              ),
            ),
          ),

          // Middle big QR button
          Positioned(
            bottom: 20, // floating above nav bar
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFCC204A), Color(0xFFFD4E25)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Nav.push(context, Scanqr());
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/icons/qr.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isActive ? Color(0xFFCC204A) : Colors.grey,
          ),
          SizedBox(height: 4),
          CustomText(
            title: label,
            color: isActive ? Color(0xFFCC204A) : Colors.grey,
            fontWeight: FontWeight.w300,
            fontSize: 11,
          ),
        ],
      ),
    );
  }
}
