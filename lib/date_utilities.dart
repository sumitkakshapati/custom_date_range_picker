class DateUtilities {
  static bool isSameDate({required DateTime current, required DateTime other}) {
    return current.year == other.year &&
        current.month == other.month &&
        current.day == other.day;
  }
}
