import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerListWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String currentValue;
  final double height;
  final FixedExtentScrollController controller;

  const DatePickerListWidget({
    Key? key,
    required this.items,
    required this.currentValue,
    required this.onChanged,
    required this.controller,
    this.height = 270,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CupertinoPicker.builder(
        itemExtent: 45,
        childCount: items.length,
        selectionOverlay: Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0x33B4B4BB),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        scrollController: controller,
        diameterRatio: 1.35,
        squeeze: 1.25,
        itemBuilder: (context, index) {
          return Container(
            height: 45,
            alignment: Alignment.center,
            child: Text(
              items[index],
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        onSelectedItemChanged: (value) {
          onChanged(items[value]);
        },
      ),
    );
  }
}
