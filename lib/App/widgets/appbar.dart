// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';



// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback onBack;
//   final VoidCallback onCaution;

//   const CustomAppBar({
//     Key? key,
//     required this.title,
//     required this.onBack,
//     required this.onCaution,
//   }) : super(key: key);

//   @override
//   Size get preferredSize => const Size.fromHeight(70);

//   @override
//   Widget build(BuildContext context) {
//     // Get status bar height
//     final double statusBarHeight = MediaQuery.of(context).padding.top;

//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
//       height: preferredSize.height + statusBarHeight,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: onBack,
//             child: _buildCircleIcon(Icons.arrow_back),
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 title,
//                 style: GoogleFonts.nunito(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: onCaution,
//             child: _buildCircleIcon(Icons.warning_amber_rounded),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCircleIcon(IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(2), // space for border
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: const Color(0xFFCC204A),
//           width: 2,
//         ),
//       ),
//       child: Container(
//         width: 32,
//         height: 32,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: LinearGradient(
//             colors: [Color(0xFFCC204A), Color(0xFFFD4E25)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: 22,
//         ),
//       ),
//     );
//   }
// }
