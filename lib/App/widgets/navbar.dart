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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Background bar
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.home, "Home", 0),
              navItem(Icons.chat, "Chat", 1),
              SizedBox(width: 60), // space for the big middle QR button
              navItem(Icons.credit_card, "Card", 3),
              navItem(Icons.settings, "Settings", 4),
            ],
          ),
        ),

        // Middle big circle button (QR)
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFCC204A), Color(0xFFFD4E25)], // always gradient
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
              child: Center(
                child: SvgPicture.asset(
  'assets/svg/icons/qr.svg',
  width: 32,
  height: 32,
  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
)

              ),
            ),
          ),
        ),
      ],
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
            color: isActive
                ? Color(0xFFCC204A) // your gradient main color for active
                : Colors.grey,       // inactive color
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

