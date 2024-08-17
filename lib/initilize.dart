
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/secur_storage_service.dart';
import 'package:hawala/shared/env.dart';


Future preInitializations() async {
  //! Init Flutter Engine
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //! Init Flutter Native Splash
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: "lib/shared/.env");

  //! Setup Injection
  await configureInjection(envType.name);

  //! Init Flutter Local Notifications
  // await initFlutterLocalNotifications();

  //! Init Firebase
  //To run Firebase Crashlytics you need to run app in (release mode)
  // await Firebase.initializeApp();
  // await initFirebase(storageService);
  // getItClient<PermissionService>();

  //! Init Secure Storage
  await getItClient<SecureStorageService>().initData();

  //! Init Config
  await getItClient<AppConfigurationService>().init();

  //! Init Socket Https
  // await getItClient<SocketService>().overrideSocket();

  //! Catch Exceptions
  // _overrideErrorWidget();
}



// /// Display error screen
// void _overrideErrorWidget() {
//   ErrorWidget.builder = (FlutterErrorDetails details) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: 1000,
//           height: 1000,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                   width: 250,
//                   height: 250,
//                   child: Image.asset(Assets.images.error.path,
//                       width: 250,
//                       height: 250)), //SvgPicture.asset(ResourcesPath.noData)
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 "Error is happened",
//                 style: TextStyle(
//                   fontSize: 24,
//                 ),
//                 overflow: TextOverflow.visible,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: 150,
//                 child: FilledButton(
//                   onPressed: () {
//                     getItClient<AppConfigurationService>()
//                         .context
//                         .to(const SplashScreen());
                    // RouteGenerator.routerClient.goNamed(Routers.homeName);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.all(14.0),
//                     child: Center(
//                       child: Text(
//                         'restart',
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   };
// }
