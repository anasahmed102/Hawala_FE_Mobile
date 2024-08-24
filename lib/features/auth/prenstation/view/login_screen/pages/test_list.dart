import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawala/features/auth/prenstation/view/login_screen/pages/test_widget.dart';
import 'package:hawala/features/customer/presentation/cubit/customers_cubit.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/widgets/failure_screen.dart';
import 'package:hawala/widgets/loading_widget.dart';
import 'package:hawala/widgets/no_data_found_widget.dart';

class CustomersListWidget extends StatefulWidget {
  const CustomersListWidget({super.key});

  @override
  State<CustomersListWidget> createState() => _CustomersListWidgetState();
}

class _CustomersListWidgetState extends State<CustomersListWidget> {
  Future<void> refresh() async {
    await getItClient<CustomersCubit>().getData(
        source: DataSource.checkNetwork,
        showMessage: ShowMessageEnum.showBothToast);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CustomersCubit, CustomersState>(
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
            return RefreshIndicator(
              onRefresh: refresh,
              child: Scrollbar(
                child: Column(
                  children: [
                    Expanded(
                      child: CustomerWidget(
                        model: status.data,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
