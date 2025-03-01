import 'package:intl/intl.dart';

List<String> getNextDays({required String type}) {
  List<String> daysNames = [];
  List<String> daysDate = [];

  for (int i = 0; i < 4; i++) {
    DateTime day = DateTime.now().add(Duration(days: i));
    String formmatedDayName = DateFormat('EEE').format(day);
    String formmatedDayDate = DateFormat('d').format(day);
    daysNames.add(formmatedDayName);
    daysDate.add(formmatedDayDate);
  }
  return type == 'date' ? daysDate : daysNames;
}