import 'package:NoblePay/App/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TransactionBox extends StatefulWidget {
  final String title;
  final String headerIcon; // svg path
  final List<TransactionItem> items; 

  const TransactionBox({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.items,
  });

  @override
  State<TransactionBox> createState() => _TransactionBoxState();
}

class _TransactionBoxState extends State<TransactionBox> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final displayItems = showAll ? widget.items : widget.items.take(4).toList();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Main Container
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.only(
            top: 16,
            left: 12,
            right: 12,
            bottom: 32, // leave space for button
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              // Header with gradient
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCC204A), Color(0xFFFD4E25)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(widget.headerIcon, width: 20, height: 20, color: Colors.white),
                    const SizedBox(width: 8),
                    CustomText(
                      title: widget.title,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Grid of items
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = displayItems[index];
                  return GestureDetector(
                    onTap: item.onTap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.asset(item.icon, width: 30, height: 30),
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          title: item.label,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          //align: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Floating expand/collapse button at bottom center

        Positioned(
          bottom:1,
          child: GestureDetector(
            onTap: () => setState(() => showAll = !showAll),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Model class for each grid item
class TransactionItem {
  final String icon; // svg path
  final String label;
  final VoidCallback onTap;

  TransactionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}