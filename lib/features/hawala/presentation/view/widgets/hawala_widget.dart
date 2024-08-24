import 'package:flutter/material.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/features/hawala/presentation/cubit/cubit/hawala_add_update_delete_cubit.dart';
import 'package:hawala/service/injection/injection.dart';

class HawalaWidget extends StatefulWidget {
  const HawalaWidget({super.key, required this.model});
  final List<HawalaModel> model;

  @override
  State<HawalaWidget> createState() => _HawalaWidgetState();
}

class _HawalaWidgetState extends State<HawalaWidget> {
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.model.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (String value) {
                            if (value == 'remove') {
                              getItClient<HawalaAddUpdateDeleteCubit>()
                                  .deleteHawala(widget.model[index].id);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'remove',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Remove'),
                              ),
                            ),
                            // const PopupMenuItem<String>(
                            //   value: 'edit',
                            //   child: ListTile(
                            //     leading: Icon(Icons.edit),
                            //     title: Text('Edit'),
                            //   ),
                            // ),
                          ],
                          icon: const Icon(Icons.more_vert), // Three dots icon
                        ),
                      ],
                    ),
                    title: Text(
                      '${widget.model[index].currency == 0 ? '\$' : widget.model[index].currency == 1 ? 'د.ع' : ''} ${widget.model[index].totalAmount}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
