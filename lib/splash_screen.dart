import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hawala/features/auth/prenstation/view/login_screen/pages/login_screen.dart';
import 'package:hawala/navigation_page.dart';
import 'package:hawala/service/connection_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/service/validator_service.dart';
import 'package:hawala/shared/logger.dart';
import 'package:hawala/shared/responsive.dart';

// import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _func();
    });
    super.initState();
  }

  _func() {
    _runListener();

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      Widget? child;

      // bool firstTime =
      //     await getItClient<SecureStorageService>().firstTimeRead();

      if (ValidatorService.checkIsNullOrEmpty(
          getItClient<ProfileNotifier>().userInfo?.access_token)) {
        child = const LoginPage();
      } else {
        child = const NavigationPage();
      }

      if (mounted) {
        try {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => child!), (route) => false);
        } catch (e) {
          logger(("error in navigation in $e"));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context, designSize: const Size(414, 896));
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: FlutterLogo(
        size: 100,
      )),
    );
  }

  void _runListener() {
    getItClient<ConnectionService>().startListen();
  }
}
