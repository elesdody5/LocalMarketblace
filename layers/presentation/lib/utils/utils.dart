import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

Future<bool> checkConnectivity() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  }
  return true;
}

extension FormateDate on DateTime {
  String get formattedDate {
    int diff = calculateDifferenceInDays(this);
    if (diff == -1) return "yesterday".tr;
    if (diff == 0) return "today".tr;
    var dateFormat = DateFormat("yyyy-MM-dd");
    String formattedDate = dateFormat.format(this);
    return formattedDate;
  }

  String get formattedDateInPeriod {
    int diffInHours = calculateDifferenceInHours(this);
    int diffInDays = calculateDifferenceInDays(this);
    int diffInWeeks = calculateDifferenceInWeeks(this);
    int diffInMonths = calculateDifferenceInMonths(this);
    int diffInYears = calculateDifferenceInYears(this);

    if (diffInHours < 1) return "now";
    if (diffInHours < 24) return "$diffInHours h";
    if (diffInDays < 7) return "$diffInDays d";
    if (diffInWeeks < 4) return "$diffInWeeks w";
    if (diffInMonths < 12) return "$diffInMonths mo";
    return "$diffInYears y";
  }
}

/// Returns the difference (in full days) between the provided date and today.
int calculateDifferenceInDays(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day)
      .difference(DateTime(date.year, date.month, date.day))
      .inDays;
}

/// Returns the difference in full hours.
int calculateDifferenceInHours(DateTime date) {
  DateTime now = DateTime.now();
  return now.difference(date).inHours;
}

/// Returns the difference in full weeks.
int calculateDifferenceInWeeks(DateTime date) {
  return calculateDifferenceInDays(date) ~/ 7;
}

/// Returns the difference in full months.
int calculateDifferenceInMonths(DateTime date) {
  DateTime now = DateTime.now();
  return (now.year - date.year) * 12 + (now.month - date.month);
}

/// Returns the difference in full years.
int calculateDifferenceInYears(DateTime date) {
  DateTime now = DateTime.now();
  return now.year - date.year;
}
