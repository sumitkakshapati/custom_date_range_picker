import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  final String title;
  final DateTime? date;
  const DateCard({super.key, required this.title, this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.4,
              color: Color(0xFF474F5C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date != null ? DateFormat('dd/MM/yyyy').format(date!) : '--/-- ',
            style: TextStyle(
              fontWeight: date != null ? FontWeight.w500 : FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color:
                  date != null ? theme.primaryColor : const Color(0xFF91979F),
            ),
          ),
        ],
      ),
    );
  }
}
