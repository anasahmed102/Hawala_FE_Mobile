import 'package:flutter/material.dart';
import 'package:hawala/gen/assets.gen.dart';

import 'package:hawala/shared/responsive.dart';

class NoDataFound extends StatelessWidget {
  final Future<void> Function() onPress;
  final String text;
  final ScrollPhysics? physics;
  const NoDataFound(
      {Key? key, this.physics, required this.onPress, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle boldTextStyle = TextStyle(
      fontSize: 20.sp,
      color: theme.textTheme.bodyLarge?.color,
    );
    return RefreshIndicator(
      onRefresh: onPress,
      child: ListView(
        shrinkWrap: true,
        physics: physics,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.flagOfIraqSvg.path,
                  height: 350.h,
                ),
                const SizedBox(height: 25),
                Text(text, style: boldTextStyle),
              ],
            ),
          )
        ],
      ),
    );
  }
}
