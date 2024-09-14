import 'package:event_creation_app/ui/event_list/event_list_view.dart';
import 'package:event_creation_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event Creation App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            brightness: Brightness.light,
            useMaterial3: true),
        home: const EventListView(),
      ),
    );
  }
}
