import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DateUtilities {
  static final List<String> englishYears =
      List.generate(100, (index) => (_englishMinDate.year + index).toString());

  static final List<String> nepaliYears =
      List.generate(100, (index) => (_nepaliMinDate.year + index).toString());

  static final _englishMinDate = DateTime(1943, 1, 1);
  static final _englishMaxDate = DateTime(2043, 12, 31);

  static final _nepaliMinDate = NepaliDateTime(2000, 1, 1);
  static final _nepaliMaxDate = NepaliDateTime(2100, 12, 30);

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

  static final List<String> nepaliMonths = [
    "Baishakh",
    "Jestha",
    "Asar",
    "Shrawan",
    "Bhadau",
    "Aswin",
    "Kartik",
    "Mansir",
    "Poush",
    "Magh",
    "Falgun",
    "Chaitra",
  ];

  static final _nepaliYearsMonthMapping = {
    1969: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    1970: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1971: [365, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
    1972: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    1973: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    1974: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1975: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    1976: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    1977: [365, 30, 32, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
    1978: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1979: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    1980: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    1981: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
    1982: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1983: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    1984: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    1985: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
    1986: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1987: [365, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    1988: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    1989: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    1990: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1991: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    1992: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    1993: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    1994: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1995: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    1996: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    1997: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    1998: [365, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
    1999: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2000: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2001: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2002: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2003: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2004: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2005: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2006: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2007: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2008: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
    2009: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2010: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2011: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2012: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
    2013: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2014: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2015: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2016: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
    2017: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2018: [365, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2019: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2020: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    2021: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2022: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    2023: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2024: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    2025: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2026: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2027: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2028: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2029: [365, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
    2030: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2031: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2032: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2033: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2034: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2035: [365, 30, 32, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
    2036: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2037: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2038: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2039: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
    2040: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2041: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2042: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2043: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
    2044: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2045: [365, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2046: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2047: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    2048: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2049: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    2050: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2051: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    2052: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2053: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    2054: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2055: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2056: [365, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
    2057: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2058: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2059: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2060: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2061: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2062: [365, 30, 32, 31, 32, 31, 31, 29, 30, 29, 30, 29, 31],
    2063: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2064: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2065: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2066: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
    2067: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2068: [365, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2069: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2070: [365, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
    2071: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2072: [365, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2073: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
    2074: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    2075: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2076: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    2077: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
    2078: [365, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
    2079: [365, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
    2080: [365, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
    2081: [366, 31, 31, 32, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2082: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2083: [365, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
    2084: [365, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
    2085: [366, 31, 32, 31, 32, 30, 31, 30, 30, 29, 30, 30, 30],
    2086: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2087: [366, 31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30],
    2088: [365, 30, 31, 32, 32, 30, 31, 30, 30, 29, 30, 30, 30],
    2089: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2090: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2091: [366, 31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30],
    2092: [365, 30, 31, 32, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2093: [365, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2094: [365, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
    2095: [366, 31, 31, 32, 31, 31, 31, 30, 29, 30, 30, 30, 30],
    2096: [364, 30, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
    2097: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
    2098: [365, 31, 31, 32, 31, 31, 31, 29, 30, 29, 30, 29, 31],
    2099: [365, 31, 31, 32, 31, 31, 31, 30, 29, 29, 30, 30, 30],
    2100: [366, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
  };

  static int _nepaliMonthIndex(String month) {
    return nepaliMonths
        .indexWhere((e) => e.toLowerCase() == month.toLowerCase());
  }

  static int findNepaliLastDate(int year, String month) {
    final years = _nepaliYearsMonthMapping[year];
    final monthIndex = _nepaliMonthIndex(month);
    if (years != null && monthIndex != -1) {
      return years[monthIndex + 1];
    } else {
      return 30;
    }
  }
}

extension DateExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isInRange({
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    if (startDate != null && endDate != null) {
      if (isAfter(startDate) && isBefore(endDate)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool matchAnyDate(List<DateTime?> dates) {
    final List<DateTime> filteredDates =
        dates.where((e) => e != null).map((e) => e!).toList();
    for (DateTime date in filteredDates) {
      if (date.isSameDate(this)) {
        return true;
      }
    }
    return false;
  }

  bool isEndDate(DateTime? endDate) {
    if (endDate != null && isSameDate(endDate)) {
      return true;
    } else if (weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDate(DateTime? startDate) {
    if (startDate != null && isSameDate(startDate)) {
      return true;
    } else if (weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  DateTime get previousDay {
    return DateTime(year, month, day - 1);
  }

  DateTime get nextDay {
    return DateTime(year, month, day + 1);
  }

  List<DateTime> get currentMonthDateLists {
    List<DateTime> currentMonthDates = [];
    final DateTime newDate = DateTime(year, month, 0);
    int previousMonthDay = 0;
    if (newDate.weekday < 7) {
      previousMonthDay = newDate.weekday;
      for (int i = 1; i <= previousMonthDay; i++) {
        currentMonthDates
            .add(newDate.subtract(Duration(days: previousMonthDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMonthDay); i++) {
      currentMonthDates.add(newDate.add(Duration(days: i + 1)));
    }
    return currentMonthDates;
  }

  // ignore: non_constant_identifier_names
  String get MMMYYYY {
    return DateFormat('MMM yyyy').format(this);
  }
}

extension NepaliDateExtension on NepaliDateTime {
  bool isSameDate(NepaliDateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isInRange({
    required NepaliDateTime? startDate,
    required NepaliDateTime? endDate,
  }) {
    if (startDate != null && endDate != null) {
      if (isAfter(startDate) && isBefore(endDate)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool matchAnyDate(List<NepaliDateTime?> dates) {
    final List<NepaliDateTime> filteredDates =
        dates.where((e) => e != null).map((e) => e!).toList();
    for (NepaliDateTime date in filteredDates) {
      if (date.isSameDate(this)) {
        return true;
      }
    }
    return false;
  }

  bool isEndDate(NepaliDateTime? endDate) {
    if (endDate != null && isSameDate(endDate)) {
      return true;
    } else if (weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDate(NepaliDateTime? startDate) {
    if (startDate != null && isSameDate(startDate)) {
      return true;
    } else if (weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  NepaliDateTime get previousDay {
    return toDateTime().previousDay.toNepaliDateTime();
  }

  NepaliDateTime get nextDay {
    return toDateTime().nextDay.toNepaliDateTime();
  }

  List<NepaliDateTime> get currentMonthDateLists {
    List<NepaliDateTime> currentMonthDates = [];
    final NepaliDateTime newDate = NepaliDateTime(year, month, 1).previousDay;
    int previousMonthDay = 0;
    if (newDate.weekday < 7) {
      previousMonthDay = newDate.weekday;
      for (int i = 1; i <= previousMonthDay; i++) {
        currentMonthDates
            .add(newDate.subtract(Duration(days: previousMonthDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMonthDay); i++) {
      currentMonthDates.add(newDate.add(Duration(days: i + 1)));
    }
    return currentMonthDates;
  }

  // ignore: non_constant_identifier_names
  String get MMMYYYY {
    return NepaliDateFormat('MMM yyyy').format(this);
  }
}
