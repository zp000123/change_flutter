

extension TimeExtension on int {
  getMinDateStampDay() {
    var dateTime = DateTime.fromMicrosecondsSinceEpoch(this);
    var minDateStampDay =
    DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
    return minDateStampDay.microsecondsSinceEpoch;
  }

  getMaxDateStampDay() {
    var dateTime = DateTime.fromMicrosecondsSinceEpoch(this);
    var maxDateStampDay =
    DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);
    return maxDateStampDay.microsecondsSinceEpoch;
  }
}
