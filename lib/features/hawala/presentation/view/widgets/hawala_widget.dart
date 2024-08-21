import 'package:flutter/material.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';

class HawalaWidget extends StatelessWidget {
  const HawalaWidget({super.key, required this.model, required this.isAll});
  final HawalaModel model;
  final bool isAll;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(model.id.toString()),
      title: Text(model.totalAmount.toString()),
    );
  }
}
