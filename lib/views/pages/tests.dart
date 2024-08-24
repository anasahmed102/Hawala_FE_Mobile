import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final Function(String?)? onChanged;

  SearchableDropdown({
    required this.items,
    required this.hint,
    this.onChanged,
  });

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  TextEditingController _controller = TextEditingController();
  List<String> _filteredItems = [];
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _selectItem(String item) {
    _controller.text = item;
    _toggleDropdown();
    widget.onChanged?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hint,
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
        ),
        if (_isDropdownOpen)
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => _filterItems(value),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: InputBorder.none,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredItems[index]),
                        onTap: () => _selectItem(_filteredItems[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
