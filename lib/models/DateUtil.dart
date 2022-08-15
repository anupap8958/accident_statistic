class DateUtil {
  var THAI_DAY = ["วันจันทร์","วันอังคาร","วันพุธ","วันพฤหัส","วันศุกร์","วันเสาร์","วันอาทิตย์"];

  String parseDateDay(String strDate) {
    DateTime parseDate = DateTime.parse(strDate);
    return '${THAI_DAY[parseDate.weekday - 1]}';
  }

  String dateDay(String strDate) {
    DateTime parseDate = DateTime.parse(strDate);
    return '${parseDate.day}';
  }
}