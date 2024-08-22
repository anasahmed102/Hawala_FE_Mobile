// import 'package:flutter/material.dart';
// import 'package:hawala/features/auth/prenstation/view/login_screen/widgets/login_widget.dart';
// import 'package:hawala/shared/responsive.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Builder(
//         builder: (context) {
//           return Scaffold(
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   // shrinkWrap: true,
//                   children: [
//                     SizedBox(height: 70.sp),
//                     SizedBox(
//                         height: 170.h,
//                         child: FlutterLogo(
//                           size: 100.sp,
//                         )),
//                     SizedBox(height: (25).sp),
//                     const LoginWidget()
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hawala/core/theme/app_theme.dart';
import 'package:hawala/features/auth/data/model/login_request.dart';
import 'package:hawala/features/auth/prenstation/cubit/auth_cubit.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/responsive.dart';

bool isSelected = false;

late TextEditingController _username;
late TextEditingController _password;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Hey there,",
                style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppTtheme.iconColor1,
                      ),
                      labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _password,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      filled: true,
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      prefixIcon: Icon(
                        Icons.password,
                        color: AppTtheme.iconColor1,
                      ),
                      labelText: "Password"),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const Text(
                    "By continuing you accept our Privacy Policy and\n Term of Use",
                    textAlign: TextAlign.start,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.064,
                width: MediaQuery.of(context).size.width * 0.77,
                child: MaterialButton(
                  onPressed: () {
                    final login = LoginRequest(
                        fname: _username.text, password: _password.text);
                    getItClient<AuthCubit>().login(
                        loginRequest: login, dataSource: DataSource.remote);
                  },
                  color: context.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 130,
                        color: AppTtheme.lineColor1,
                      ),
                      const Text("  or  "),
                      Container(
                        height: 1,
                        width: 130,
                        color: AppTtheme.lineColor1,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(16))),
                        child: Icon(
                          FontAwesomeIcons.facebook,
                          color: AppTtheme.facebookIconColor,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                          height: 50,
                          width: 50,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(16))),
                          child: const Icon(FontAwesomeIcons.google)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    // String username = "Mohamd dhkiqd@aljazary.com";
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    String usernameT = "test";
    _username = TextEditingController(text: kReleaseMode ? "" : usernameT);
    _password = TextEditingController(text: kReleaseMode ? "" : "1234");
  }
}
