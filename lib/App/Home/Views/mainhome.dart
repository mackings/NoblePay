import 'package:NoblePay/App/widgets/menubox.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background SVG
            SvgPicture.asset(
              'assets/svg/dash.svg',
              width: MediaQuery.of(context).size.width,
              height: 270,
              fit: BoxFit.fill,
            ),

            // Welcome text overlay
            Positioned(
              top: 60,
              left: 20,
              child: Text(
                "Welcome 👋",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Transaction box overlayed below the header
            Positioned(
              top: 30,
              left: 0,
              right: 0,
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
          ],
        ),
      ),
    );
  }
}
