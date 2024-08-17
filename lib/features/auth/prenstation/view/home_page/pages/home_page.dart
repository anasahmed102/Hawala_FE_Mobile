// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: Column(children: [
//          Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(16.0),
//                 boxShadow: [
//                   const BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-14, -14),
//                     blurRadius: 8,
//                     inset: true,
//                   ),
//                   BoxShadow(
//                     color: Colors.grey.shade400,
//                     offset: const Offset(14, 14),
//                     blurRadius: 8,
//                     inset: true,
//                   ),
//                 ],
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.place, color: AppTheme.primaryColor),
//                     hintText: "Meeting Address",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],)),
//     );
//   }
// }