import 'package:flutter/material.dart';
import 'package:hawala/features/auth/prenstation/view/login_screen/widgets/login_widget.dart';
import 'package:hawala/shared/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    SizedBox(height: 70.sp),
                    SizedBox(
                        height: 170.h,
                        child: FlutterLogo(
                          size: 100.sp,
                        )),
                    SizedBox(height: (25).sp),
                    const LoginWidget()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
