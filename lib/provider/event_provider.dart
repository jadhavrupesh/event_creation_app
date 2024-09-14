import 'package:event_creation_app/data/event_model.dart';
import 'package:flutter/cupertino.dart';

class EventProvider with ChangeNotifier {
  String? _eventName;
  String? _eventDescription;
  DateTime? _selectedDate;
  String? _selectedYear;
  String? _selectedMonth;

  String? get eventName => _eventName;

  String? get eventDescription => _eventDescription;

  DateTime? get selectedDate => _selectedDate;

  String? get selectedYear => _selectedYear;

  String? get selectedMonth => _selectedMonth;

  List<EventModel> listEventModel = [];

  final List<int> years = List.generate(10, (index) => 2016 + index);
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void setYear(String selectedYear) {
    _selectedYear = selectedYear;
    notifyListeners();
  }

  void setMonth(String selectedMonth) {
    _selectedMonth = selectedMonth;
    notifyListeners();
  }

  void setEvent(String name, String description, DateTime date) {
    _eventName = name;
    _eventDescription = description;
    _selectedDate = date;
    var eventModel = EventModel(
        eventName: name, eventDescription: description, selectedDate: date);
    listEventModel.add(eventModel);
    notifyListeners();
  }

  EventModel? getEventData(DateTime currentDate) {
    for (var event in listEventModel) {
      if (event.selectedDate.day == currentDate.day &&
          event.selectedDate.month == currentDate.month &&
          event.selectedDate.day == currentDate.day) {
        return event;
      }
    }
    return null;
  }
}
