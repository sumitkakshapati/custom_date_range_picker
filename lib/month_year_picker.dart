import 'package:custom_date_range_picker/date_picker_list_widget.dart';
import 'package:custom_date_range_picker/date_utilities.dart';
import 'package:flutter/material.dart';

class MonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onChanged;
  const MonthYearPicker({
    super.key,
    required this.initialDate,
    required this.onChanged,
  });

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  String currentYear = "";
  String currentMonth = "";

  late FixedExtentScrollController _yearController;

  late FixedExtentScrollController _monthController;

  @override
  void initState() {
    super.initState();
    currentYear = widget.initialDate.year.toString();
    currentMonth = DateUtilities.englishMonths[widget.initialDate.month - 1];
    final int yearIndex = DateUtilities.englishYears.indexOf(currentYear);
    _yearController = FixedExtentScrollController(
        initialItem: yearIndex == -1 ? 0 : yearIndex);
    _monthController =
        FixedExtentScrollController(initialItem: widget.initialDate.month - 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 382,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DatePickerListWidget(
                  items: DateUtilities.englishYears,
                  currentValue: currentYear,
                  controller: _yearController,
                  onChanged: (val) {
                    currentYear = val;
                  },
                ),
              ),
              Expanded(
                child: DatePickerListWidget(
                  items: DateUtilities.englishMonths,
                  currentValue: currentMonth.toString(),
                  controller: _monthController,
                  onChanged: (val) {
                    currentMonth = val;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: theme.primaryColor,
            onPressed: () {
              final currentMonthIndex =
                  DateUtilities.englishMonths.indexOf(currentMonth);
              widget.onChanged(
                  DateTime(int.parse(currentYear), currentMonthIndex + 1));
            },
            minWidth: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
