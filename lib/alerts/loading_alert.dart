import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/connection_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/responsive.dart';
import 'package:provider/provider.dart';


Future<void> showLoadingProgressAlert(
    {BuildContext? contextParam, bool? isProgress}) async {
  BuildContext context =
      contextParam ?? getItClient<AppConfigurationService>().context;
  showDialog<void>(
    useRootNavigator: true,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: isProgress != true
            ? SizedBox(
                width: 60.sp,
                height: 60.sp,
                child: SpinKitCubeGrid(
                    size: 60.sp, color: Theme.of(context).primaryColor))
            : Center(
                child: Consumer<ConnectionService>(
                  builder: (context, myType, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: 100.sp,
                          height: 100.sp,
                          decoration: BoxDecoration(
                              color: context.scaffoldBackgroundColor,
                              shape: BoxShape.circle),

                          child: SpinKitSpinningLines(
                            size: 100.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                          // child: CircularProgressIndicator(
                          //   value: myType.current == myType.total &&
                          //           myType.current == 0
                          //       ? null
                          //       : myType.current / myType.total,
                          // ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${myType.current}"),
                            Text("/${myType.total}")
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
      );
    },
  );
}
