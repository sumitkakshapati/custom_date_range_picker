import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderHeader extends StatelessWidget {
  final List<DateTime> dateList;
  const CalenderHeader({super.key, required this.dateList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Row(
        children: _getDaysNameUI(),
      ),
    );
  }

  List<Widget> _getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('E').format(dateList[i]),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF474F5C),
              ),
            ),
          ),
        ),
      );
    }
    return listUI;
  }
}
