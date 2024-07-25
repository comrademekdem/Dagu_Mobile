import 'package:dagu/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  CategoryChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Chip(
        label: Text(label),
        backgroundColor:
            isSelected ? DaguColors.primaryColor : Colors.grey[300],
        shape: StadiumBorder(
          side: BorderSide(color: DaguColors.primaryColor),
        ),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
