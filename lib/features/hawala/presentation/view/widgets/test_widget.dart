import 'package:flutter/material.dart';

import 'package:hawala/alerts/toast.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/gen/assets.gen.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/luncher_service.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/responsive.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({Key? key, required this.model, required this.isAll})
      : super(key: key);
  final HawalaModel model;
  final bool isAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        //! Inkwell
        // borderRadius: BorderRadius.circular(BORDER_RADUIS),
        onTap: () {
          showToast('Clicked');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Builder(builder: (context) {
            //LayoutBuilder constraints
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: context.primaryColor),
                  borderRadius: BorderRadius.circular(16)),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.images.flagOfTurkeySvg.path,
                          width: 50.sp,
                          height: 50.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.id.toString(),
                          style: TextStyle(fontSize: 20.sp),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: context.iconColor)),
                            child: Icon(Icons.phone,
                                color: context.iconColor, size: 16.sp),
                          ),
                          onTap: () {
                            getItClient<LauncherService>()
                                .openPhoneCall(""); //model.phoneNo
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            //! Inkwell
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: context.iconColor)),
                              child: Icon(Icons.map,
                                  color: context.iconColor, size: 16.sp),
                            ),
                            onTap: () {
                              // showOpenWithMapBottomSheet(
                              //     context: context,
                              //     title: model.series,
                              //     lat: 0,
                              //     long: 0
                              //     // title: model.customerName,
                              //     // lat: model.lat,
                              //     // long: model.long
                              //     );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
