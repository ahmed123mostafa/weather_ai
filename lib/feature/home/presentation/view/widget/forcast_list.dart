
import 'package:flutter/material.dart';

import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_day_weather.dart';
import 'package:intl/intl.dart';

class ForcastDaysList extends StatefulWidget {
  const ForcastDaysList(
      {super.key, required this.onTap, this.selectedIndex = 0});
  final Function(int index)? onTap;
  final int? selectedIndex;

  @override
  State<ForcastDaysList> createState() => _ForcastDaysListState();
}

class _ForcastDaysListState extends State<ForcastDaysList> {
  int isSelected = 0;
  List<String> daysNames = getNextDays(type: 'name');
  List<String> daysDate = getNextDays(type: 'date');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:MediaQuery.of(context).size.height * 0.13,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            width: 20,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: daysNames.length,
          itemBuilder: (context, index) => InkWell(
            onTap: ()  {
              isSelected = index;
              setState(() {});
               widget.onTap!(index);
            },
            child: ForcastDayItem(
                dayName: daysNames[index],
                date: daysDate[index],
                color: widget.selectedIndex == index
                    ? Colors.white.withAlpha(100)
                    : Colors.blue.withAlpha(100)),
          ),
        ),
      ),
    );
  }
}
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