import 'package:custom_date_range_picker/calender_type.dart';
import 'package:custom_date_range_picker/date_picker_list_widget.dart';
import 'package:custom_date_range_picker/date_utilities.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

class MonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onChanged;
  final CalenderType type;
  const MonthYearPicker({
    super.key,
    required this.initialDate,
    required this.onChanged,
    required this.type,
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
    final nepaliDate = widget.initialDate.toNepaliDateTime();
    currentYear = widget.type.isAD
        ? widget.initialDate.year.toString()
        : nepaliDate.year.toString();
    currentMonth = widget.type.isAD
        ? DateUtilities.englishMonths[widget.initialDate.month - 1]
        : DateUtilities.nepaliMonths[nepaliDate.month - 1];
    final int yearIndex = widget.type.isAD
        ? DateUtilities.englishYears.indexOf(currentYear)
        : DateUtilities.nepaliYears.indexOf(currentYear);
    _yearController = FixedExtentScrollController(
        initialItem: yearIndex == -1 ? 0 : yearIndex);
    _monthController = FixedExtentScrollController(
        initialItem:
            (widget.type.isAD ? widget.initialDate.month : nepaliDate.month) -
                1);
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
                  items: widget.type == CalenderType.AD
                      ? DateUtilities.englishYears
                      : DateUtilities.nepaliYears,
                  currentValue: currentYear,
                  controller: _yearController,
                  onChanged: (val) {
                    currentYear = val;
                  },
                ),
              ),
              Expanded(
                child: DatePickerListWidget(
                  items: widget.type == CalenderType.AD
                      ? DateUtilities.englishMonths
                      : DateUtilities.nepaliMonths,
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
              if (widget.type.isAD) {
                final currentMonthIndex =
                    DateUtilities.englishMonths.indexOf(currentMonth);
                widget.onChanged(
                    DateTime(int.parse(currentYear), currentMonthIndex + 1));
              } else {
                final currentMonthIndex =
                    DateUtilities.nepaliMonths.indexOf(currentMonth);
                final nepaliDate = NepaliDateTime(
                    int.parse(currentYear), currentMonthIndex + 1);
                widget.onChanged(nepaliDate.toDateTime());
              }
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
