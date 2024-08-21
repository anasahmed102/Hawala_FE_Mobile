import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawala/features/auth/data/model/login_request.dart';
import 'package:hawala/features/auth/prenstation/cubit/auth_cubit.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/responsive.dart';

late TextEditingController _username;
late TextEditingController _password;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool isSecure = false;

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextField(
              controller: _username,
            ),
            SizedBox(height: (15).sp),
            StatefulBuilder(builder: (BuildContext context, setState) {
              return TextField(
                controller: _password,
              );
            }),
            SizedBox(height: 30.h),
            ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                child: const Text("data"))
          ],
        ),
      ),
    );
  }

  Future<void> handleLogin() async {
    final login = LoginRequest(fname: _username.text, password: _password.text);
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      getItClient<AuthCubit>()
          .login(dataSource: DataSource.remote, loginRequest: login);
    }
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
