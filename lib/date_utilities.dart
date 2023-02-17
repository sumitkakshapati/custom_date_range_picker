class DateUtilities {
  static bool isSameDate({required DateTime current, required DateTime other}) {
    return current.year == other.year &&
        current.month == other.month &&
        current.day == other.day;
  }

  static bool isInRange({
    required DateTime? startDate,
    required DateTime? endDate,
    required DateTime date,
  }) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate) && date.isBefore(endDate)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static bool isStartOrEndDate({
    required DateTime? startDate,
    required DateTime? endDate,
    required DateTime date,
  }) {
    if (startDate != null &&
        startDate.day == date.day &&
        startDate.month == date.month &&
        startDate.year == date.year) {
      return true;
    } else if (endDate != null &&
        endDate.day == date.day &&
        endDate.month == date.month &&
        endDate.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  static final List<String> englishYears =
      List.generate(100, (index) => (1943 + index).toString());

  static final List<String> englishMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
}
