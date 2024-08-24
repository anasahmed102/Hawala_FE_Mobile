import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawala/core/theme/app_theme.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/features/hawala/presentation/cubit/cubit/hawala_add_update_delete_cubit.dart';
import 'package:hawala/service/data_formatting_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:intl/intl.dart';

final TextEditingController _username = TextEditingController();

class AddHawala extends StatefulWidget {
  const AddHawala({
    super.key,
    required this.model,
  });
  final List<CustomersModel> model;

  @override
  State<AddHawala> createState() => _AddHawalaState();
}

final Map<String, int> _textToNumberMap = {
  'Hawala': 0,
  'Hisab': 1,
};
final Map<String, int> _textTomap = {
  'Dollar': 0,
  'Dinar': 1,
};

String? _selectedText;
String? _selectedText1;
int? _selectedCustomerId;

class _AddHawalaState extends State<AddHawala> {
  final NumberFormat _formatter = NumberFormat('#,###');
  final TextEditingController menuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Add Hawala"),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  filled: true,
                  labelText: "Select a greeting",
                ),
                value: _selectedText,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedText = newValue;
                  });
                },
                items: _textToNumberMap.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  filled: true,
                  labelText: "Select a currency",
                ),
                value: _selectedText1,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedText1 = newValue;
                  });
                },
                items: _textTomap.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12.0),
              DropdownMenu(
                controller: menuController,
                width: width,
                hintText: "Select a Customer",
                requestFocusOnTap: true,
                enableFilter: true,
                label: const Text('Select a Customer'),
                onSelected: (CustomersModel? customer) {
                  setState(() {
                    _selectedCustomerId = customer?.id;
                  });
                },
                dropdownMenuEntries: widget.model
                    .map<DropdownMenuEntry<CustomersModel>>(
                        (CustomersModel customer) {
                  return DropdownMenuEntry<CustomersModel>(
                    value: customer,
                    label: customer.customerName,
                  );
                }).toList(),
              ),
              const SizedBox(height: 12.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: _username,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  filled: true,
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  prefixIcon: Icon(
                    Icons.password,
                    color: AppTtheme.iconColor1,
                  ),
                  labelText: "Total Amount",
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  final data = HawalaModel(
                    currency: _textTomap[_selectedText1]!,
                    fullPaid: false,
                    paidAmount:
                        int.tryParse(_username.text.replaceAll(',', '')) ?? 0,
                    totalAmount:
                        int.tryParse(_username.text.replaceAll(',', '')) ?? 0,
                    postingDate: getItClient<DateFormatterService>()
                        .getCurrentDateTimeUTC(),
                    type: _textToNumberMap[_selectedText]!,
                    customerId: _selectedCustomerId!,
                  );
                  getItClient<HawalaAddUpdateDeleteCubit>().addCustomer(data);
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _username.addListener(_formatNumber);
    String usernameT = "0";
    _username.text = kReleaseMode ? "" : usernameT;
  }

  void _formatNumber() {
    String text = _username.text.replaceAll(',', '');
    if (text.isNotEmpty) {
      final formattedText = _formatter.format(int.tryParse(text) ?? 0);
      _username.value = _username.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
}
