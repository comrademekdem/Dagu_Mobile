import 'package:dagu/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;

  CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(color: DaguColors.primaryColor),
      ),
      labelStyle: TextStyle(
        color: DaguColors.primaryColor,
      ),
    );
  }
}
