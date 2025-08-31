import 'package:NoblePay/App/widgets/menubox.dart';
import 'package:NoblePay/App/widgets/navbar.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {

    int selectedIndex = 0;

  final List<Widget> pages = [
    Center(child: Text("Home Page")),
    Center(child: Text("Chat Page")),
    Center(child: Text("QR Page")),
    Center(child: Text("Card Page")),
    Center(child: Text("Settings Page")),
  ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Stack for background + welcome text
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/svg/dash.svg',
                    width: MediaQuery.of(context).size.width,
                    height: 270,
                    fit: BoxFit.fill,
                  ),
Positioned(
  top: 60,
  left: 20,
  right: 20, // ensures Row takes full width
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Welcome + username
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
CustomText(title: "Welcome",color: Colors.white,fontWeight: FontWeight.w300,),
          SizedBox(height: 4), // small spacing
CustomText(title: "Mac kingsley!",color: Colors.white,)
        ],
      ),



      // User avatar
Container(
  width: 48, // diameter = 2 * radius
  height: 48,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.transparent, // optional background
  ),
  child: ClipOval(
    child: SvgPicture.asset(
      'assets/svg/icons/BG.svg', // your SVG file
      fit: BoxFit.cover,
    ),
  ),
),

    ],
  ),
),

                ],
              ),

              // Transaction box floating over SVG
              Transform.translate(
                offset: Offset(0, -60), // lifts the box up over the SVG
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TransactionBox(
                    title: "Transactions",
                    headerIcon: "assets/svg/icons/card.svg",
                    items: [
                      TransactionItem(
                        icon: "assets/svg/icons/send.svg",
                        label: "Send Money",
                        onTap: () => print("Send Money clicked"),
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/recharge.svg",
                        label: "Mobile Recharge",
                        onTap: () {},
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/ticket.svg",
                        label: "E-Tickets",
                        onTap: () {},
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/billpay.svg",
                        label: "Bill Pay",
                        onTap: () {},
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/merchant.svg",
                        label: "Pay Merchant",
                        onTap: () {},
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/rental.svg",
                        label: "Rentals",
                        onTap: () {},
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/marketplace.svg",
                        label: "Market place",
                        onTap: () {},
                      ),
                      TransactionItem(
                        icon: "assets/svg/icons/btc.svg",
                        label: "Digital Assets",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}

