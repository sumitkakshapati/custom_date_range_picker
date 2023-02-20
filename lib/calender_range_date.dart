import 'package:custom_date_range_picker/calender_type.dart';
import 'package:nepali_utils/nepali_utils.dart';

class CalenderRangeDate {
  final DateTime startDateInAD;
  final DateTime endDateInAD;
  final NepaliDateTime startDateInBS;
  final NepaliDateTime endDateInBS;
  final CalenderType type;

  CalenderRangeDate({
    required this.startDateInAD,
    required this.endDateInAD,
    required this.startDateInBS,
    required this.endDateInBS,
    required this.type,
  });

  factory CalenderRangeDate.fromAD(DateTime startDate, DateTime endDate) {
    return CalenderRangeDate(
      startDateInAD: startDate,
      endDateInAD: endDate,
      startDateInBS: startDate.toNepaliDateTime(),
      endDateInBS: endDate.toNepaliDateTime(),
      type: CalenderType.AD,
    );
  }

  factory CalenderRangeDate.fromBS(
      NepaliDateTime startDate, NepaliDateTime endDate) {
    return CalenderRangeDate(
      startDateInAD: startDate.toDateTime(),
      endDateInAD: endDate.toDateTime(),
      startDateInBS: startDate,
      endDateInBS: endDate,
      type: CalenderType.BS,
    );
  }
}
