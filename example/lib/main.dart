import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Range Picker',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? startDate;
  DateTime? endDate;
  String formatedStartDate = "-";
  String formatedEndDate = "-";
  CalenderType type = CalenderType.AD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Date Range Picker",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, bottom: 16),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Choose a date Range',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$formatedStartDate / $formatedEndDate',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  if (startDate != null || endDate != null)
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          startDate = null;
                          endDate = null;
                          formatedStartDate = "-";
                          formatedEndDate = "-";
                        });
                      },
                      child: const Text(
                        "Clear Dates",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDateRangePicker(
            context,
            dismissible: true,
            endDate: endDate,
            startDate: startDate,
            primaryColor: const Color(0xFF57559B),
            calenderType: type,
            onApplyClick: (rangeDate) {
              type = rangeDate.type;
              endDate = rangeDate.endDateInAD;
              startDate = rangeDate.startDateInAD;
              if (rangeDate.type.isAD) {
                setState(() {
                  formatedStartDate = DateFormat("dd-MMMM-yyyy")
                      .format(rangeDate.startDateInAD);
                  formatedEndDate =
                      DateFormat("dd-MMMM-yyyy").format(rangeDate.endDateInAD);
                });
              } else {
                setState(() {
                  formatedStartDate = NepaliDateFormat("dd-MMMM-yyyy")
                      .format(rangeDate.startDateInBS);
                  formatedEndDate = NepaliDateFormat("dd-MMMM-yyyy")
                      .format(rangeDate.endDateInBS);
                });
              }
            },
          );
        },
        tooltip: 'Choose date Range',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
    );
  }
}
