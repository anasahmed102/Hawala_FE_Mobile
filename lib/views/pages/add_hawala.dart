import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawala/core/theme/app_theme.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/features/hawala/presentation/cubit/cubit/hawala_add_update_delete_cubit.dart';
import 'package:hawala/service/data_formatting_service.dart';
import 'package:hawala/service/injection/injection.dart';

late TextEditingController _username;

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
int? _selectedCustomerId; // To store the selected customer ID

class _AddHawalaState extends State<AddHawala> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: const Text("Select a greeting"),
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
            DropdownButton<String>(
              hint: const Text("Select a greeting"),
              value: _selectedText1,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedText1 = newValue;
                });
              },
              items:
                  _textTomap.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<int>(
              hint: const Text("Select a Customer"),
              value: _selectedCustomerId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedCustomerId = newValue;
                });
              },
              items: widget.model
                  .map<DropdownMenuItem<int>>((CustomersModel customer) {
                return DropdownMenuItem<int>(
                  value: customer.id, // Store customer ID
                  child:
                      Text(customer.customerName), // Display the customer name
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
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
            ),
            ElevatedButton(
                onPressed: () {
                  final data = HawalaModel(
                    currency: _textTomap[_selectedText1]!,
                    fullPaid: false,
                    paidAmount: int.tryParse(_username.text) ?? 0,
                    totalAmount: int.tryParse(_username.text) ?? 0,
                    postingDate: getItClient<DateFormatterService>()
                        .getCurrentDateTimeUTC(),
                    type: _textToNumberMap[_selectedText]!,
                    customerId:
                        _selectedCustomerId!, // Use the selected customer ID
                  );
                  getItClient<HawalaAddUpdateDeleteCubit>().addCustomer(data);
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    String usernameT = "test";
    _username = TextEditingController(text: kReleaseMode ? "" : usernameT);
  }
}
