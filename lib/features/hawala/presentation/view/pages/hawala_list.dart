
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawala/features/hawala/presentation/cubit/hawala_cubit.dart';
import 'package:hawala/features/hawala/presentation/view/widgets/hawala_widget.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/data_formatting_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/widgets/failure_screen.dart';
import 'package:hawala/widgets/loading_widget.dart';
import 'package:hawala/widgets/no_data_found_widget.dart';

class HawalaListWidget extends StatefulWidget {
  const HawalaListWidget({super.key});

  @override
  State<HawalaListWidget> createState() => _HawalaListWidgetState();
}

class _HawalaListWidgetState extends State<HawalaListWidget> {
  DateTimeRange? selectedDateRange;
  bool _isUpdatingDateRange = false; // Local loading flag

  Future<void> updateDateRange(DateTimeRange picked) async {
    setState(() {
      _isUpdatingDateRange = true;
      selectedDateRange = picked;
    });

    await getItClient<HawalaCubit>().getData(
      startDate: getItClient<DateFormatterService>()
          .getStartOfDayUTC(selectedDateRange!.start),
      endDate: getItClient<DateFormatterService>()
          .getEndOfDayUTC(selectedDateRange!.end),
      source: DataSource.checkNetwork,
      showMessage: ShowMessageEnum.showBothToast,
    );

    setState(() {
      _isUpdatingDateRange = false;
    });
  }

  Future<void> refresh() async {
    if (selectedDateRange != null) {
      await getItClient<HawalaCubit>().getData(
        startDate: getItClient<DateFormatterService>()
            .getStartOfDayUTC(selectedDateRange!.start),
        endDate: getItClient<DateFormatterService>()
            .getEndOfDayUTC(selectedDateRange!.end),
        source: DataSource.checkNetwork,
        showMessage: ShowMessageEnum.showBothToast,
      );
    } else {
      DateTime now = DateTime.now();
      await getItClient<HawalaCubit>().getData(
        startDate: getItClient<DateFormatterService>().getStartOfDayUTC(now),
        endDate: getItClient<DateFormatterService>().getEndOfDayUTC(now),
        source: DataSource.checkNetwork,
        showMessage: ShowMessageEnum.showBothToast,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hawala"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              if (_isUpdatingDateRange) {
                return;
              }

              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                initialDateRange: selectedDateRange,
              );

              if (picked != null && picked != selectedDateRange) {
                await updateDateRange(picked);
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<HawalaCubit, HawalaState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (_isUpdatingDateRange) {
            return const Center(child: LoadingWidget());
          } else if (state is LoadingCurrencyState) {
            return const Center(child: LoadingWidget());
          } else if (state is ErrorCurrencyState) {
            return FailureScreen(failure: state.failure, onRefresh: refresh);
          } else if (state is EmptyCurrencyState) {
            return NoDataFound(
                onPress: refresh,
                text: Trans.noDataFound.trans(context: context));
          } else if (state is LoadedCurrencyState) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: Scrollbar(
                child: HawalaWidget(
                  model: state.data,
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
