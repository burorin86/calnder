import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('カレンダー'),
      ),
      body: TableCalendar(
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              final text = DateFormat.E().format(day);

              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            if (day.weekday == DateTime.saturday){
              final text = DateFormat.E().format(day);

              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.blue),
                ),
              );
            }
          },
        ),
        headerStyle: HeaderStyle(
          formatButtonShowsNext: false,
          titleCentered: true,
          formatButtonVisible: true,
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonTextStyle: TextStyle(
          ),
          titleTextStyle: TextStyle(
              fontSize: 30.0
          ),
        ),
        calendarStyle: CalendarStyle(
          weekendTextStyle: TextStyle(
            color: Colors.red,
          ),
          todayDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle
          ),
          selectedDecoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              shape: BoxShape.circle
          ),
        ),
        locale: 'ja_JP',
        firstDay: DateTime.utc(2020, 10, 25),
        lastDay: DateTime.utc(2030, 10, 25),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },

        startingDayOfWeek: StartingDayOfWeek.monday,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),

    );
  }
}
