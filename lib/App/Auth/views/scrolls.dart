import 'package:NoblePay/App/Auth/views/signin.dart';
import 'package:NoblePay/App/widgets/navigator.dart';
import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Scrolls extends StatefulWidget {
  const Scrolls({super.key});

  @override
  State<Scrolls> createState() => _ScrollsState();
}


class _ScrollsState extends State<Scrolls> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;

  final List<Map<String, String>> slides = [
    {
      "image": "assets/svg/card.svg",
      "title": "Send\nMoney",
      "subtitle":
          "Send Money safely, affordably, and instantly to your loved ones, friends, and family in Liberia using NoblePay.",
    },
    {
      "image": "assets/svg/merchant.svg",
      "title": "Merchant\nPay",
      "subtitle":
          "No more double charges, Merchant Pay is everything you need to safely, instantly, and conveniently pay for goods and services in Liberia using NoblePay.",
    },
    {
      "image": "assets/svg/utility.svg",
      "title": "Mobile\nRecharge",
      "subtitle":
          "Nothing above sharing, because sharing is caring! The faster way to Send Mobile top-ups to your families, friends, and loved ones.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset('assets/svg/ol1.svg', fit: BoxFit.contain),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: slides.length,
                    itemBuilder: (context, index, realIndex) {
                      final slide = slides[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            slide["image"]!,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 290,
                          ),
                          const SizedBox(height: 20),

                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 39,
                            ),
                            title: CustomText(
                              title: slide["title"]!,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.left,
                            ),
                            subtitle: CustomText(
                              title: slide["subtitle"]!,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700]!,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      height: double.infinity,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: slides.asMap().entries.map((entry) {
                    return Container(
                      width: _currentPage == entry.key ? 12.0 : 8.0,
                      height: _currentPage == entry.key ? 12.0 : 8.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 20.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == entry.key
                            ? Colors.red
                            : Colors.grey[400],
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // _carouselController.jumpToPage(slides.length - 1);
                          Nav.push(context, Signin());
                        },
                        child: CustomText(
                          title: "Skip",
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_currentPage < slides.length - 1) {
                            _carouselController.nextPage();
                          } else {
                            // Finished, go to next screen
                          }
                        },
                        child: Row(
                          children: const [
                            CustomText(
                              title: "Next",
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_right_alt,
                              color: Colors.red,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
