extension TimeExtension on int {
  getMinDateStampDay() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    var minDateStampDay =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
    return minDateStampDay.millisecondsSinceEpoch;
  }

  getMaxDateStampDay() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    var maxDateStampDay =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);
    return maxDateStampDay.millisecondsSinceEpoch;
  }

  getMinDateStampMonth() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    var minDateStampDay = DateTime(dateTime.year, dateTime.month, 1);
    return minDateStampDay.millisecondsSinceEpoch;
  }

  getMaxDateStampMonth() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    var dataNextMonthData = new DateTime(dateTime.year, dateTime.month + 1, 1);
    return dataNextMonthData.millisecondsSinceEpoch - 1;
  }
}
