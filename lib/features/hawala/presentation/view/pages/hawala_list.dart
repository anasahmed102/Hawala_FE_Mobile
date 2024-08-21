import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hawala/features/hawala/presentation/cubit/hawala_cubit.dart';
import 'package:hawala/features/hawala/presentation/view/widgets/hawala_widget.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/widgets/failure_screen.dart';
import 'package:hawala/widgets/loading_widget.dart';
import 'package:hawala/widgets/no_data_found_widget.dart';

class HawalaListWidget extends StatelessWidget {
  const HawalaListWidget({super.key});
  Future<void> refresh() async {
    await getItClient<HawalaCubit>().getData(
        source: DataSource.checkNetwork,
        showMessage: ShowMessageEnum.showBothToast);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<HawalaCubit, HawalaState>(
          listener: (context, status) {},
          builder: (context, status) {
            if (status is LoadingCurrencyState || status is HawalaInitial) {
              return const LoadingWidget();
            } else if (status is ErrorCurrencyState) {
              return FailureScreen(failure: status.failure, onRefresh: refresh);
            } else if (status is EmptyCurrencyState) {
              return NoDataFound(
                  onPress: refresh,
                  text: Trans.noDataFound.trans(context: context));
            } else if (status is LoadedCurrencyState) {
              return Column(
                children: [
                  Expanded(
                      child: RefreshIndicator(
                          onRefresh: refresh,
                          child: Scrollbar(
                            child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: status.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return HawalaWidget(
                                    isAll: false, model: status.data[index]);
                              },
                            ),
                            // child: MasonryGridView.count(
                            //   crossAxisCount:
                            //       getCustomerAxisCount(context.width),
                            //   crossAxisSpacing: 10,
                            //   mainAxisSpacing: 10,
                            //   physics: const BouncingScrollPhysics(
                            //       parent: AlwaysScrollableScrollPhysics()),
                            //   itemCount: status.data.length,
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return CustomerWidget(
                            //         isAll: false, model: status.data[index]);
                            //   },
                            // ),
                          ))),
                ],
              );
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }
}
