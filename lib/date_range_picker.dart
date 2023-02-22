import 'package:custom_date_range_picker/calender_range_date.dart';
import 'package:custom_date_range_picker/calender_type.dart';
import 'package:custom_date_range_picker/color_generator.dart';
import 'package:custom_date_range_picker/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

/// `CustomDateRangePicker({
///   Key? key,
///   this.initialStartDate,
///   this.initialEndDate,
///   required this.onApplyClick,
///   this.barrierDismissible = true,
///   required this.minimumDate,
///   required this.maximumDate,
///   required this.onCancelClick,
/// }`
class CustomDateRangePicker extends StatefulWidget {
  final DateTime? minimumDate;

  final DateTime? maximumDate;

  final bool barrierDismissible;

  final DateTime? initialStartDate;

  final DateTime? initialEndDate;

  final Function(CalenderRangeDate date) onApplyClick;

  final Color? primaryColor;

  final CalenderType? calenderType;

  const CustomDateRangePicker({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApplyClick,
    this.barrierDismissible = true,
    required this.minimumDate,
    required this.maximumDate,
    required this.primaryColor,
    this.calenderType,
  }) : super(key: key);

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? startDate;

  DateTime? endDate;

  late CalenderType calenderType;

  @override
  void initState() {
    calenderType = widget.calenderType ?? CalenderType.AD;
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    super.initState();
  }

  String get formatedStartEndDate {
    if (startDate != null && endDate != null) {
      if (calenderType.isAD) {
        return "${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate!)}";
      } else {
        return "${NepaliDateFormat('dd/MM/yyyy').format(startDate!.toNepaliDateTime())} - ${NepaliDateFormat('dd/MM/yyyy').format(endDate!.toNepaliDateTime())}";
      }
    } else if (startDate != null && endDate == null) {
      if (calenderType.isAD) {
        return DateFormat('dd/MM/yyyy').format(startDate!);
      } else {
        return NepaliDateFormat('dd/MM/yyyy')
            .format(startDate!.toNepaliDateTime());
      }
    } else {
      return "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    final primarySwatch = ColorGenerator.generateMaterialColor(
      color: widget.primaryColor ?? Theme.of(context).primaryColor,
    );
    return Theme(
      data: ThemeData(
        primarySwatch: primarySwatch,
      ),
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              if (widget.barrierDismissible) {
                Navigator.pop(context);
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(4, 4),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: primarySwatch.shade100,
                            border: Border.all(color: primarySwatch),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF474F5C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatedStartEndDate,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primarySwatch.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomCalendar(
                          minimumDate: widget.minimumDate,
                          maximumDate: widget.maximumDate,
                          initialEndDate: widget.initialEndDate,
                          initialStartDate: widget.initialStartDate,
                          initialCalenderType: calenderType,
                          onTypeChanged: (type) {
                            setState(() {
                              calenderType = type;
                            });
                          },
                          startEndDateChange:
                              (DateTime? startDateData, DateTime? endDateData) {
                            setState(() {
                              startDate = startDateData;
                              endDate = endDateData;
                            });
                          },
                          onClear: () {
                            setState(() {
                              startDate = null;
                              endDate = null;
                            });
                          },
                          onSetPressed: () {
                            CalenderRangeDate rangeDate;
                            if (calenderType.isAD) {
                              rangeDate = CalenderRangeDate.fromAD(
                                startDate!,
                                endDate,
                              );
                            } else {
                              rangeDate = CalenderRangeDate.fromBS(
                                startDate!.toNepaliDateTime(),
                                endDate?.toNepaliDateTime(),
                              );
                            }
                            widget.onApplyClick(rangeDate);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// `showCustomDateRangePicker(
///   BuildContext context, {
///   required bool dismissible,
///   required DateTime minimumDate,
///   required DateTime maximumDate,
///   DateTime? startDate,
///   DateTime? endDate,
///   required Function(DateTime startDate, DateTime endDate) onApplyClick,
///   required Function() onCancelClick,
///   Color? backgroundColor,
///   Color? primaryColor,
///   String? fontFamily,
/// })`
void showCustomDateRangePicker(
  BuildContext context, {
  required bool dismissible,
  DateTime? minimumDate,
  DateTime? maximumDate,
  DateTime? startDate,
  DateTime? endDate,
  required Function(CalenderRangeDate rangeDate) onApplyClick,
  Color? backgroundColor,
  Color? primaryColor,
  String? fontFamily,
  CalenderType? calenderType,
}) {
  FocusScope.of(context).requestFocus(FocusNode());
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => CustomDateRangePicker(
      barrierDismissible: true,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      initialStartDate: startDate,
      initialEndDate: endDate,
      onApplyClick: onApplyClick,
      primaryColor: primaryColor,
      calenderType: calenderType,
    ),
  );
}
