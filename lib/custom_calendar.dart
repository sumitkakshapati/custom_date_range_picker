import 'package:custom_date_range_picker/calendar_type_section.dart';
import 'package:custom_date_range_picker/calender_header.dart';
import 'package:custom_date_range_picker/calender_english_month_widget.dart';
import 'package:custom_date_range_picker/calender_nepali_month_widget.dart';
import 'package:custom_date_range_picker/calender_text_button.dart';
import 'package:custom_date_range_picker/calender_type.dart';
import 'package:custom_date_range_picker/color_generator.dart';
import 'package:custom_date_range_picker/date_utilities.dart';
import 'package:custom_date_range_picker/month_year_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

/// `const CustomCalendar({
///   Key? key,
///   this.initialStartDate,
///   this.initialEndDate,
///   this.startEndDateChange,
///   this.minimumDate,
///   this.maximumDate,
/// })`
class CustomCalendar extends StatefulWidget {
  final DateTime? minimumDate;

  final DateTime? maximumDate;

  final DateTime? initialStartDate;

  final DateTime? initialEndDate;

  final Function(DateTime?, DateTime?) startEndDateChange;

  final VoidCallback onClear;

  final VoidCallback onSetPressed;

  final ValueChanged<CalenderType> onTypeChanged;

  final CalenderType initialCalenderType;

  const CustomCalendar({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    required this.startEndDateChange,
    this.minimumDate,
    this.maximumDate,
    required this.onClear,
    required this.onSetPressed,
    required this.onTypeChanged,
    required this.initialCalenderType,
  }) : super(key: key);

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  final List<DateTime> _englishDateList = <DateTime>[];
  final List<NepaliDateTime> _nepaliDateList = <NepaliDateTime>[];
  late CalenderType _currentCalenderType;
  bool _isMonthYearPickerSelected = false;

  late DateTime _currentMonthDate;

  DateTime? _startDate;

  DateTime? _endDate;

  @override
  void initState() {
    _currentCalenderType = widget.initialCalenderType;
    if (widget.initialStartDate != null) {
      _startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      _endDate = widget.initialEndDate;
    }
    _currentMonthDate = _endDate ?? DateTime.now();
    _setListOfDate(_currentMonthDate);
    super.initState();
  }

  void _setListOfDate(DateTime monthDate) {
    _englishDateList.clear();
    _englishDateList.addAll(monthDate.currentMonthDateLists);
    _nepaliDateList.clear();
    _nepaliDateList.addAll(monthDate.toNepaliDateTime().currentMonthDateLists);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primarySwatch =
        ColorGenerator.generateMaterialColor(color: theme.primaryColor);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  onTap: () {
                    setState(() {
                      _currentMonthDate = DateTime(
                          _currentMonthDate.year, _currentMonthDate.month, 0);
                      _setListOfDate(_currentMonthDate);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      CupertinoIcons.left_chevron,
                      color: theme.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  onTap: () {
                    setState(() {
                      _currentMonthDate = DateTime(_currentMonthDate.year,
                          _currentMonthDate.month + 2, 0);
                      _setListOfDate(_currentMonthDate);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: theme.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMonthYearPickerSelected = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _currentCalenderType == CalenderType.AD
                        ? _currentMonthDate.MMMYYYY
                        : _currentMonthDate.toNepaliDateTime().MMMYYYY,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: primarySwatch.shade400,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CalenderTypeSection(
                onChanged: (type) {
                  setState(() {
                    _currentCalenderType = type;
                  });
                  widget.onTypeChanged(type);
                },
                initial: _currentCalenderType,
              ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isMonthYearPickerSelected
              ? MonthYearPicker(
                  initialDate: _currentMonthDate,
                  type: _currentCalenderType,
                  onChanged: (value) {
                    setState(() {
                      _isMonthYearPickerSelected = false;
                      _currentMonthDate = value;
                    });
                    _setListOfDate(value);
                  },
                )
              : Column(
                  children: [
                    CalenderHeader(dateList: _englishDateList),
                    if (_currentCalenderType == CalenderType.AD)
                      CalenderEnglishMonthWidget(
                        currentMonthDate: _currentMonthDate,
                        currentMonthDays: _englishDateList,
                        onDateClick: _onEnglishDateClick,
                        startDate: _startDate,
                        endDate: _endDate,
                        maximumDate: widget.maximumDate,
                        minimumDate: widget.minimumDate,
                      ),
                    if (_currentCalenderType == CalenderType.BS)
                      CalenderNepaliMonthWidget(
                        currentMonthDate: _currentMonthDate.toNepaliDateTime(),
                        currentMonthDays: _nepaliDateList,
                        onDateClick: (value) {
                          _onEnglishDateClick(value.toDateTime());
                        },
                        startDate: _startDate?.toNepaliDateTime(),
                        endDate: _endDate?.toNepaliDateTime(),
                        maximumDate: widget.maximumDate?.toNepaliDateTime(),
                        minimumDate: widget.minimumDate?.toNepaliDateTime(),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CalenderTextButton(
                          title: "Clear",
                          onPressed: () {
                            _startDate = null;
                            _endDate = null;
                            widget.onClear();
                          },
                        ),
                        CalenderTextButton(
                          title: "Set",
                          isDisabled: _startDate == null || _endDate == null,
                          onPressed: widget.onSetPressed,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  void _onEnglishDateClick(DateTime date) {
    if (_startDate == null) {
      _startDate = date;
    } else if (_startDate != date && _endDate == null) {
      _endDate = date;
    } else if (_startDate!.isSameDate(date)) {
      _startDate = null;
    } else if (_endDate!.isSameDate(date)) {
      _endDate = null;
    }
    if (_startDate == null && _endDate != null) {
      _startDate = _endDate;
      _endDate = null;
    }
    if (_startDate != null && _endDate != null) {
      if (!_endDate!.isAfter(_startDate!)) {
        final DateTime d = _startDate!;
        _startDate = _endDate;
        _endDate = d;
      }
      if (date.isBefore(_endDate!)) {
        _startDate = date;
      }
      if (date.isAfter(_startDate!)) {
        _endDate = date;
      }
    }
    setState(() {
      try {} catch (_) {}
    });
    widget.startEndDateChange(_startDate, _endDate);
  }
}
