import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget(
      {@required this.label, this.icon, this.isSet = true, this.onDeleted});

  final IconData icon;
  final String label;
  final bool isSet;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    if (!isSet) {
      return Container();
    }
    return Chip(
      onDeleted: onDeleted,
      backgroundColor: PRIMARY_RED,
      deleteIconColor: Colors.white,
      avatar: CircleAvatar(
        child: Icon(icon),
      ),
      label: Text(label, style: const TextStyle(color: Colors.white),),
    );
  }
}
