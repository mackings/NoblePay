import 'package:noblepay/App/widgets/menubox.dart';
import 'package:noblepay/App/widgets/text.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Welcome",
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              title: "Mac kingsley!",
                              color: Colors.white,
                            ),
                          ],
                        ),

                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Image.asset(
                            'assets/png/BGimg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Transform.translate(
                offset: Offset(0, -60),
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
