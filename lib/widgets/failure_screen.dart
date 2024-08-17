import 'package:flutter/material.dart';

import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/widgets/failed_load_page.dart';
import 'package:hawala/widgets/network_error_widget.dart';
import 'package:hawala/widgets/no_data_found_widget.dart';

import '../../core/error/failures.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({
    Key? key,
    required this.failure,
    required this.onRefresh,
  }) : super(key: key);
  final Failure failure;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    final String reason = failure.error.toString();
    if ((failure is NetworkFailure)) {
      return NetWorkErrorWidget(onPress: onRefresh, text: reason);
    } else if ((failure is ErrorFailure)) {
      return FailedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is UnAuthFailure)) {
      return FailedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is ServerFailure)) {
      return FailedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is EmptyData)) {
      return NoDataFound(
          onPress: onRefresh, text: Trans.noDataFound.trans(context: context));
    } else {
      return FailedLoadPageWIdget(
          onPress: onRefresh,
          text: Trans.failedLoadData.trans(context: context));
    }
  }
}
