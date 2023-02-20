import 'package:custom_date_range_picker/color_generator.dart';
import 'package:custom_date_range_picker/date_utilities.dart';
import 'package:flutter/material.dart';

class CalenderEnglishMonthWidget extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<DateTime> currentMonthDays;
  final DateTime currentMonthDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final ValueChanged<DateTime> onDateClick;
  const CalenderEnglishMonthWidget({
    super.key,
    this.startDate,
    this.endDate,
    required this.currentMonthDate,
    required this.currentMonthDays,
    this.minimumDate,
    this.maximumDate,
    required this.onDateClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getDaysNoUI(context),
    );
  }

  List<Widget> _getDaysNoUI(BuildContext context) {
    final primarySwatch = ColorGenerator.generateMaterialColor(
        color: Theme.of(context).primaryColor);
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < currentMonthDays.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = currentMonthDays[count];
        final bool isStartDateRadius = date.isStartDate(startDate);
        final bool isEndDateRadius = date.isEndDate(endDate);
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
                          left: isStartDateRadius ? 4 : 0,
                          right: isEndDateRadius ? 4 : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: startDate != null && endDate != null
                                ? date.matchAnyDate([startDate, endDate]) ||
                                        date.isInRange(
                                            startDate: startDate,
                                            endDate: endDate)
                                    ? primarySwatch.shade100
                                    : Colors.transparent
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: isStartDateRadius
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                              topLeft: isStartDateRadius
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                              topRight: isEndDateRadius
                                  ? const Radius.circular(4)
                                  : const Radius.circular(0.0),
                              bottomRight: isEndDateRadius
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
                        if (currentMonthDate.month == date.month) {
                          if (minimumDate != null && maximumDate != null) {
                            if (date.isAfter(minimumDate!.previousDay) &&
                                date.isBefore(maximumDate!.nextDay)) {
                              onDateClick(date);
                            }
                          } else if (minimumDate != null) {
                            if (date.isAfter(minimumDate!.previousDay)) {
                              onDateClick(date);
                            }
                          } else if (maximumDate != null) {
                            if (date.isBefore(maximumDate!.nextDay)) {
                              onDateClick(date);
                            }
                          } else {
                            onDateClick(date);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: date.matchAnyDate([startDate, endDate])
                                ? primarySwatch
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: date.matchAnyDate([startDate, endDate])
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
                                  color: date.matchAnyDate([startDate, endDate])
                                      ? Colors.white
                                      : currentMonthDate.month == date.month
                                          ? const Color(0xFF474F5C)
                                          : const Color(0xFFB4B4BB),
                                  fontSize: 12,
                                  fontWeight:
                                      date.matchAnyDate([startDate, endDate])
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
                        color: DateTime.now().isSameDate(date)
                            ? date.isInRange(
                                startDate: startDate,
                                endDate: endDate,
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
}
