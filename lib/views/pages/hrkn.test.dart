import 'package:flutter/material.dart';

// Remove the MenuItem model

List<Map<String, dynamic>> menuItems = [
  {'id': 1, 'label': 'Home', 'icon': Icons.home},
  {'id': 2, 'label': 'Profile', 'icon': Icons.person},
  {'id': 3, 'label': 'Settings', 'icon': Icons.settings},
  {'id': 4, 'label': 'Favorites', 'icon': Icons.favorite},
  {'id': 5, 'label': 'Notifications', 'icon': Icons.notifications},
  {'id': 6, 'label': 'Messages', 'icon': Icons.message},
  {'id': 7, 'label': 'Explore', 'icon': Icons.explore},
  {'id': 8, 'label': 'Search', 'icon': Icons.search},
  {'id': 9, 'label': 'Chat', 'icon': Icons.chat},
  {'id': 10, 'label': 'Calendar', 'icon': Icons.calendar_today},
];

class DropdownMenuSample extends StatefulWidget {
  const DropdownMenuSample({super.key});

  @override
  State<DropdownMenuSample> createState() => _DropdownMenuSampleState();
}

class _DropdownMenuSampleState extends State<DropdownMenuSample> {
  Map<String, dynamic>? selectedMenu;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;
    final TextEditingController menuController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'DropdownMenu',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            DropdownMenu<Map<String, dynamic>>(
              initialSelection: selectedMenu,
              controller: menuController,
              width: width,
              hintText: "Select Menu",
              requestFocusOnTap: true,
              enableFilter: true,
              menuStyle: MenuStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlue.shade50),
              ),
              label: const Text('Select Menu'),
              onSelected: (Map<String, dynamic>? menu) {
                setState(() {
                  selectedMenu = menu;
                });
              },
              dropdownMenuEntries: menuItems
                  .map<DropdownMenuEntry<Map<String, dynamic>>>(
                      (Map<String, dynamic> menu) {
                return DropdownMenuEntry<Map<String, dynamic>>(
                    value: menu,
                    label: menu['label'],
                    leadingIcon: Icon(menu['icon']));
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              selectedMenu != null
                  ? 'Selected: ${selectedMenu!['label']}'
                  : 'No item selected',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
