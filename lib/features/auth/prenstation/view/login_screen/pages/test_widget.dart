import 'package:flutter/material.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/customer/presentation/cubit/cubit/add_update_delete_customer_cubit.dart';
import 'package:hawala/features/customer/presentation/cubit/customers_cubit.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/responsive.dart';

late TextEditingController _username;
late TextEditingController _phoneNumber;

Future<void> refresh() async {
  await getItClient<CustomersCubit>().getData(
      source: DataSource.checkNetwork,
      showMessage: ShowMessageEnum.showBothToast);
}

class CustomerWidget extends StatefulWidget {
  const CustomerWidget({
    super.key,
    required this.model,
  });

  final List<CustomersModel> model;

  @override
  _CustomerWidgetState createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  CustomersModel? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: 40.w,
            ),
            const Center(
                child: Text(
              "Customer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Add Customer"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _username,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.task,
                                  ),
                                  labelText: "Customer name"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _phoneNumber,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.task,
                                  ),
                                  labelText: "Phone Number"),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.24,
                            child: MaterialButton(
                              color: context.primaryColor,
                              onPressed: () {
                                final model = CustomersModel(
                                    phone: _phoneNumber.text,
                                    customerName: _username.text);
                                getItClient<AddUpdateDeleteCustomerCubit>()
                                    .addCustomer(model);
                                if (_username.text.isEmpty) return;
                                setState(() {
                                  _username.text = "";
                                });
                                Navigator.pop(context);
                              },
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: widget.model.length,
            itemBuilder: (context, index) {
              return ListTile(
                subtitle: Text(widget.model[index].phone),
                leading: Text(widget.model[index].id.toString()),
                title: Text(widget.model[index].customerName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'remove') {
                          getItClient<AddUpdateDeleteCustomerCubit>()
                              .deleteCustomer(widget.model[index].id);
                        } else if (value == 'edit') {
                          // Pre-fill the TextField with the current customer name
                          _username.text = widget.model[index].customerName;

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Edit Customer"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _username,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.task,
                                        ),
                                        labelText: "Customer name",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.31,
                                    child: MaterialButton(
                                      color: context.primaryColor,
                                      onPressed: () {
                                        final model = CustomersModel(
                                          phone: widget.model[index].phone,
                                          id: widget.model[index].id,
                                          customerName:
                                              _username.text, // Updated name
                                        );
                                        getItClient<
                                                AddUpdateDeleteCustomerCubit>()
                                            .updateCustomer(model);

                                        // Close the dialog after updating
                                        Navigator.pop(context);
                                      },
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.update,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Update",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
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
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          ),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert), // Three dots icon
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _username = TextEditingController();
    _phoneNumber = TextEditingController();
    super.initState();
  }
}
