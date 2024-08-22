import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawala/features/customer/presentation/cubit/customers_cubit.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/views/pages/add_hawala.dart';
import 'package:hawala/widgets/failure_screen.dart';
import 'package:hawala/widgets/loading_widget.dart';
import 'package:hawala/widgets/no_data_found_widget.dart';

class HawalaAddListWidget extends StatefulWidget {
  const HawalaAddListWidget({super.key});

  @override
  State<HawalaAddListWidget> createState() => _HawalaAddListWidgetState();
}

class _HawalaAddListWidgetState extends State<HawalaAddListWidget> {
  Future<void> refresh() async {
    await getItClient<CustomersCubit>().getData(
        source: DataSource.checkNetwork,
        showMessage: ShowMessageEnum.showBothToast);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<CustomersCubit, CustomersState>(
          listener: (context, status) {},
          builder: (context, status) {
            if (status is LoadingCustomersState || status is CustomersInitial) {
              return const LoadingWidget();
            } else if (status is ErrorCustomersState) {
              return FailureScreen(failure: status.failure, onRefresh: refresh);
            } else if (status is EmptyCustomersState) {
              return NoDataFound(
                  onPress: refresh,
                  text: Trans.noDataFound.trans(context: context));
            } else if (status is LoadedCustomersState) {
              return AddHawala(
                model: status.data,
              );
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }
}
