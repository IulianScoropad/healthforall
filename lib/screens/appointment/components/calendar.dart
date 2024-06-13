import '../../../constants.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const Calendar({super.key, required this.onDateSelected});
  @override
  CalendarState createState() => CalendarState();
}


class CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now();

  int currentDateSelectedIndex = 0;

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            listOfMonths[DateTime.now().month - 1],
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: defaultPadding);
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    currentDateSelectedIndex = index;
                    selectedDate = DateTime.now().add(Duration(days: index));
                    widget.onDateSelected(selectedDate);
                  });
                },
                child: Container(
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: currentDateSelectedIndex == index
                        ? primaryColor
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateTime.now()
                            .add(Duration(days: index))
                            .day
                            .toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: currentDateSelectedIndex == index
                              ? Colors.white
                              : textColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        listOfDays[DateTime.now()
                                    .add(Duration(days: index))
                                    .weekday -
                                1]
                            .toString(),
                        style: TextStyle(
                          color: currentDateSelectedIndex == index
                              ? Colors.white
                              : textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}