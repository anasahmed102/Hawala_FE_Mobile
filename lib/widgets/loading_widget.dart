import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hawala/shared/responsive.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.height}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? (MediaQuery.of(context).size.height - (200)),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SpinKitSpinningLines(
            size: 100.sp,
            color: Theme.of(context).primaryColor,
          ),
        ));
  }
}
