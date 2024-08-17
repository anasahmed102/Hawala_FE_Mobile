// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:medicalapp/gen/assets.gen.dart';

// class AnimationPage extends StatefulWidget {
//   const AnimationPage({super.key});

//   @override
//   State<AnimationPage> createState() => _AnimationPageState();
// }

// class _AnimationPageState extends State<AnimationPage>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 2));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   bool bookmarked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListTile(
//           title: const Text("sadada"),
//           trailing: GestureDetector(
//               onTap: () {
//                 if (bookmarked == false) {
//                   bookmarked = true;
//                   _controller.forward();
//                 } else {
//                   bookmarked = false;
//                   _controller.reverse();
//                 }
//               },
            
//         ),
//       ),
//     );
//   }
// }
