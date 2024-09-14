import 'package:event_creation_app/provider/event_provider.dart';
import 'package:event_creation_app/ui/create_event/create_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventListView extends StatefulWidget {
  const EventListView({super.key});

  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (BuildContext context, EventProvider viewModel, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Event List')),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectYear(context, viewModel),
                    child: Text(viewModel.selectedYear ?? 'Select Year'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectMonth(context, viewModel),
                    child: Text(viewModel.selectedMonth ?? 'Select Month'),
                  ),
                ],
              ),
              Expanded(
                child: viewModel.selectedYear != null &&
                        viewModel.selectedMonth != null
                    ? _buildDaysList(context, viewModel)
                    : const Center(child: Text('Please select year and month')),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectYear(
      BuildContext context, EventProvider viewModel) async {
    final year = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: viewModel.years.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(viewModel.years[index].toString()),
              onTap: () => Navigator.pop(context, viewModel.years[index]),
            );
          },
        );
      },
    );

    if (year != null) {
      viewModel.setYear(year.toString());
      (context as Element).markNeedsBuild();
    }
  }

  Future<void> _selectMonth(
      BuildContext context, EventProvider viewModel) async {
    final month = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: viewModel.months.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(viewModel.months[index]),
              onTap: () => Navigator.pop(context, viewModel.months[index]),
            );
          },
        );
      },
    );

    if (month != null) {
      viewModel.setMonth(month.toString());
      (context as Element).markNeedsBuild(); // Refresh the UI
    }
  }

  Widget _buildDaysList(BuildContext context, EventProvider viewModel) {
    final year = int.parse(viewModel.selectedYear!);
    final month = viewModel.months.indexOf(viewModel.selectedMonth!);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    return ListView.builder(
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        final day = index + 1;
        final currentDate = DateTime(year, month + 1, day);
        var savedEvent = viewModel.getEventData(currentDate);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              final selectedDate = DateTime(year, month + 1, day);
              print("Data is Saved and selectedDate = $selectedDate");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreateEventScreen(selectedDate: selectedDate),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            day.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          Text(
                            viewModel.months[month],
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 48,
                        child: VerticalDivider(
                          thickness: 4,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (savedEvent != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                      "${savedEvent.selectedDate.hour}:${savedEvent.selectedDate.minute}"),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                      "${savedEvent.selectedDate.day}/${savedEvent.selectedDate.month}/${savedEvent.selectedDate.year}"),
                                ],
                              ),
                            )
                          else
                            const SizedBox(),
                          if (savedEvent != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Text(savedEvent.eventName),
                            )
                          else
                            const SizedBox(),
                          if (savedEvent != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Text(savedEvent.eventDescription),
                            )
                          else
                            const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
