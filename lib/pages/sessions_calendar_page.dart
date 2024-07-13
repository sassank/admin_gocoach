import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SessionsCalendarPage extends StatefulWidget {
  const SessionsCalendarPage({super.key});

  @override
  SessionsCalendarPageState createState() => SessionsCalendarPageState();
}

class SessionsCalendarPageState extends State<SessionsCalendarPage> {
  late _DataSource _events;
  late CalendarView _currentView;
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek,
    CalendarView.timelineMonth,
  ];
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    _currentView = CalendarView.week;
    _calendarController.view = _currentView;
    _events = _DataSource(getAppointmentDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget calendar = Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          secondary: Colors.teal,
        ),
      ),
      child: _getDragAndDropCalendar(_calendarController, _events, _onViewChanged),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning des sessions'),
      ),
      body: Row(children: <Widget>[
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: calendar,
          ),
        ),
      ]),
    );
  }

  void _onViewChanged(ViewChangedDetails viewChangedDetails) {
    if (_currentView != CalendarView.month &&
        _calendarController.view != CalendarView.month) {
      _currentView = _calendarController.view!;
      return;
    }

    _currentView = _calendarController.view!;
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        // Update the scroll view when view changes.
      });
    });
  }

  List<Appointment> getAppointmentDetails() {
    final List<String> subjectCollection = <String>[
      'Yoga Session',
      'Workout',
      'Strength Training',
      'Cardio Blast',
      'Pilates',
      'Boxing Class',
      'Dance Fitness',
      'Stretch & Relax',
      'Cycling Class',
      'CrossFit'
    ];

    final List<Color> colorCollection = <Color>[
      const Color(0xFF0F8644),
      const Color(0xFF8B1FA9),
      const Color(0xFFD20100),
      const Color(0xFFFC571D),
      const Color(0xFF36B37B),
      const Color(0xFF01A1EF),
      const Color(0xFF3D4FB5),
      const Color(0xFFE47C73),
      const Color(0xFF636363),
      const Color(0xFF0A8043)
    ];

    final List<Appointment> appointments = <Appointment>[];
    final Random random = Random();
    DateTime today = DateTime.now();
    final DateTime rangeStartDate = today.add(const Duration(days: -(365 ~/ 2)));
    final DateTime rangeEndDate = today.add(const Duration(days: 365));
    for (DateTime i = rangeStartDate;
    i.isBefore(rangeEndDate);
    i = i.add(const Duration(days: 1))) {
      final DateTime date = i;
      final int count = random.nextInt(2);
      for (int j = 0; j < count; j++) {
        final DateTime startDate =
        DateTime(date.year, date.month, date.day, 8 + random.nextInt(8));
        appointments.add(Appointment(
          subject: subjectCollection[random.nextInt(10)],
          startTime: startDate,
          endTime: startDate.add(Duration(hours: random.nextInt(3))),
          color: colorCollection[random.nextInt(10)],
        ));
      }
    }

    today = DateTime(today.year, today.month, today.day, 9);
    // added recurrence appointment
    appointments.add(Appointment(
        subject: 'Weekly Yoga Session',
        startTime: today,
        endTime: today.add(const Duration(hours: 2)),
        color: colorCollection[random.nextInt(10)],
        recurrenceRule: 'FREQ=WEEKLY;BYDAY=FR;INTERVAL=1'));
    return appointments;
  }

  SfCalendar _getDragAndDropCalendar(
      [CalendarController? calendarController,
        CalendarDataSource? calendarDataSource,
        ViewChangedCallback? viewChangedCallback]) {
    return SfCalendar(
      controller: calendarController,
      dataSource: calendarDataSource,
      allowedViews: _allowedViews,
      showNavigationArrow: true,
      onViewChanged: viewChangedCallback,
      allowDragAndDrop: true,
      showDatePickerButton: true,
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      timeSlotViewSettings: const TimeSlotViewSettings(
          minimumAppointmentDuration: Duration(minutes: 60)),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}