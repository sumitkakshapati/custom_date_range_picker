import 'dart:ui';

import 'package:custom_date_range_picker/calendar_type_section.dart';
import 'package:custom_date_range_picker/calender_header.dart';
import 'package:custom_date_range_picker/calender_text_button.dart';
import 'package:custom_date_range_picker/calender_type.dart';
import 'package:custom_date_range_picker/color_generator.dart';
import 'package:custom_date_range_picker/date_utilities.dart';
import 'package:custom_date_range_picker/month_year_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  const CustomCalendar({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    required this.startEndDateChange,
    this.minimumDate,
    this.maximumDate,
    required this.onClear,
    required this.onSetPressed,
  }) : super(key: key);

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  final List<DateTime> _dateList = <DateTime>[];
  CalenderType _currentCalenderType = CalenderType.AD;
  bool _isMonthYearPickerSelected = false;

  late DateTime _currentMonthDate;

  DateTime? _startDate;

  DateTime? _endDate;

  @override
  void initState() {
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

  @override
  void dispose() {
    super.dispose();
  }

  void _setListOfDate(DateTime monthDate) {
    _dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        _dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      _dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      size: 20,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMonthYearPickerSelected = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    DateFormat('MMMM yyyy').format(_currentMonthDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF474F5C),
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
                      size: 20,
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
                    CalenderHeader(dateList: _dateList),
                    Column(
                      children: _getDaysNoUI(),
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

  List<Widget> _getDaysNoUI() {
    final primarySwatch = ColorGenerator.generateMaterialColor(
        color: Theme.of(context).primaryColor);
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < _dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = _dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: _isStartDateRadius(date) ? 4 : 0,
                          right: _isEndDateRadius(date) ? 4 : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _startDate != null && _endDate != null
                                ? DateUtilities.isStartOrEndDate(
                                          startDate: _startDate,
                                          endDate: _endDate,
                                          date: date,
                                        ) ||
                                        DateUtilities.isInRange(
                                          startDate: _startDate,
                                          endDate: _endDate,
                                          date: date,
                                        )
                                    ? primarySwatch.shade100
                                    : Colors.transparent
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: _isStartDateRadius(date)
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                              topLeft: _isStartDateRadius(date)
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                              topRight: _isEndDateRadius(date)
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                              bottomRight: _isEndDateRadius(date)
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      onTap: () {
                        if (_currentMonthDate.month == date.month) {
                          if (widget.minimumDate != null &&
                              widget.maximumDate != null) {
                            final DateTime newminimumDate = DateTime(
                                widget.minimumDate!.year,
                                widget.minimumDate!.month,
                                widget.minimumDate!.day - 1);
                            final DateTime newmaximumDate = DateTime(
                                widget.maximumDate!.year,
                                widget.maximumDate!.month,
                                widget.maximumDate!.day + 1);
                            if (date.isAfter(newminimumDate) &&
                                date.isBefore(newmaximumDate)) {
                              _onDateClick(date);
                            }
                          } else if (widget.minimumDate != null) {
                            final DateTime newminimumDate = DateTime(
                                widget.minimumDate!.year,
                                widget.minimumDate!.month,
                                widget.minimumDate!.day - 1);
                            if (date.isAfter(newminimumDate)) {
                              _onDateClick(date);
                            }
                          } else if (widget.maximumDate != null) {
                            final DateTime newmaximumDate = DateTime(
                                widget.maximumDate!.year,
                                widget.maximumDate!.month,
                                widget.maximumDate!.day + 1);
                            if (date.isBefore(newmaximumDate)) {
                              _onDateClick(date);
                            }
                          } else {
                            _onDateClick(date);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: DateUtilities.isStartOrEndDate(
                              startDate: _startDate,
                              endDate: _endDate,
                              date: date,
                            )
                                ? primarySwatch
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: DateUtilities.isStartOrEndDate(
                              startDate: _startDate,
                              endDate: _endDate,
                              date: date,
                            )
                                ? <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        blurRadius: 4,
                                        offset: const Offset(0, 0)),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                  color: DateUtilities.isStartOrEndDate(
                                    startDate: _startDate,
                                    endDate: _endDate,
                                    date: date,
                                  )
                                      ? Colors.white
                                      : _currentMonthDate.month == date.month
                                          ? const Color(0xFF474F5C)
                                          : const Color(0xFFB4B4BB),
                                  fontSize: 12,
                                  fontWeight: DateUtilities.isStartOrEndDate(
                                    startDate: _startDate,
                                    endDate: _endDate,
                                    date: date,
                                  )
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 9,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: DateTime.now().day == date.day &&
                                DateTime.now().month == date.month &&
                                DateTime.now().year == date.year
                            ? DateUtilities.isInRange(
                                startDate: _startDate,
                                endDate: _endDate,
                                date: date,
                              )
                                ? Colors.white
                                : primarySwatch
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool _isStartDateRadius(DateTime date) {
    if (_startDate != null &&
        _startDate!.day == date.day &&
        _startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool _isEndDateRadius(DateTime date) {
    if (_endDate != null &&
        _endDate!.day == date.day &&
        _endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void _onDateClick(DateTime date) {
    if (_startDate == null) {
      _startDate = date;
    } else if (_startDate != date && _endDate == null) {
      _endDate = date;
    } else if (DateUtilities.isSameDate(current: _startDate!, other: date)) {
      _startDate = null;
    } else if (DateUtilities.isSameDate(current: _endDate!, other: date)) {
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
