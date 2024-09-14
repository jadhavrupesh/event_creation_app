import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/event_provider.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  final DateTime selectedDate;

  CreateEventScreen({required this.selectedDate});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    print("Data is Saved and selectedDate = ${widget.selectedDate}");

    return Consumer<EventProvider>(
      builder: (BuildContext context, EventProvider viewModel, Widget? child) {
        DateTime dateTime = DateTime.parse(widget.selectedDate.toString());
        String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
        return Scaffold(
          appBar: AppBar(title: const Text('Create Event')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text("Selected Time: "),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime ?? TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.grey, // Example color
                          ),
                        ),
                        child: Text(selectedTime != null
                            ? selectedTime!.format(context)
                            : '00:00'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(formattedDate),
                  ],
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Event Title'),
                ),
                TextField(
                  controller: descriptionController,
                  minLines: 1,
                  maxLines: 10,
                  decoration:
                  const InputDecoration(labelText: 'Event Description'),
                ),

                const SizedBox(height: 20),

                // Save button
                ElevatedButton(
                  onPressed: () {
                    final eventName = nameController.text;
                    final eventDescription = descriptionController.text;

                    if (selectedTime != null) {
                      final DateTime eventDateTime = DateTime(
                        widget.selectedDate.year,
                        widget.selectedDate.month,
                        widget.selectedDate.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      Provider.of<EventProvider>(context, listen: false).setEvent(eventName, eventDescription, eventDateTime);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text('Please select a time for the event')),
                      );
                    }
                  },
                  child: const Text('Save Event'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
