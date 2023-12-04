import 'package:coody_common_flutter/src/styles/app_colors.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart' hide isSameDay;

typedef CalendarCellBuilder = Widget Function(
    BuildContext context, DateTime day, DateTime focusedDay);

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    required this.firstDay,
    required this.lastDay,
    this.defaultBuilder,
    this.todayBuilder,
    this.selectedBuilder,
    this.onPageChanged,
    this.onDaySelected,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final CalendarCellBuilder? defaultBuilder;
  final CalendarCellBuilder? todayBuilder;
  final CalendarCellBuilder? selectedBuilder;
  final void Function(DateTime focusedDay)? onPageChanged;
  final void Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Widget _defaultBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return CalendarCell(date: day);
  }

  Widget _todayBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return CalendarCell(
      date: day,
      backgroundColor: null,
      foregroundColor: context.colors.blue,
    );
  }

  Widget _selectedBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    final isToday = isSameDay(day, DateTime.now());

    return CalendarCell(
      date: day,
      backgroundColor: isToday ? context.colors.blue.opacity20 : context.colors.blue,
      foregroundColor: isToday ? context.colors.blue : context.colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: widget.firstDay,
      lastDay: widget.lastDay,
      focusedDay: _focusedDay,
      daysOfWeekHeight: 42.0,
      rowHeight: 42.0,
      sixWeekMonthsEnforced: true,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        headerMargin: EdgeInsets.zero,
        headerPadding: EdgeInsets.zero,
      ),
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        cellMargin: EdgeInsets.only(top: 8.0),
      ),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return SizedBox(
            height: 34.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                day.format(DateFormat.yM()),
                style: context.typography.title1.emphasized,
              ),
            ),
          );
        },
        dowBuilder: (context, day) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: 34.0,
              height: 34.0,
              child: Center(
                child: Text(
                  DateFormat.E('en').format(day).toUpperCase(),
                  style: context.typography.caption1.emphasized.copyWith(
                    color: context.colors.gray5,
                  ),
                ),
              ),
            ),
          );
        },
        defaultBuilder: widget.defaultBuilder ?? _defaultBuilder,
        todayBuilder: widget.todayBuilder ?? _todayBuilder,
        selectedBuilder: widget.selectedBuilder ?? _selectedBuilder,
      ),
      onPageChanged: (focusedDay) {
        var day = focusedDay;
        if (isSameMonth(focusedDay, DateTime.now())) {
          day = DateTime.now();
        }

        setState(() {
          _selectedDay = day;
          _focusedDay = day;
        });
        widget.onPageChanged?.call(day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDaySelected?.call(selectedDay, focusedDay);
      },
    );
  }
}

class CalendarCell extends StatelessWidget {
  const CalendarCell({
    super.key,
    required this.date,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundBuilder,
  });

  final DateTime date;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget Function(BuildContext context, Widget child)? backgroundBuilder;

  Widget _childBuilder(BuildContext context, {required Widget child}) {
    if (backgroundBuilder != null) return backgroundBuilder!.call(context, child);
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(maxHeight: 34.0, maxWidth: 34.0),
      child: _childBuilder(
        context,
        child: Center(
          child: Text(
            date.day.toString(),
            style: context.typography.body1.emphasized.copyWith(
              color: foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
