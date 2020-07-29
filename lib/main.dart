import 'package:Tracker_app/pages/addTaskPage.dart';
import 'package:flutter/material.dart';
import './models/objective.dart';
import './pages/homePage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './pages/testpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      // routes: {'/addtask': (ctx) => AddTaskBody()},
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static DateTime get mondayIndex {
    var foo = 1;
    var monday = DateTime.now();

    while (monday.weekday != foo) {
      monday = monday.subtract(Duration(days: 1));
    }
    return monday;
  }

  final _currentObjectives = DummyObjectives;

  void _addTask(
    final String id,
    final DateTime date,
    final Recurring recurring,
    final String title,
    final String deviceId,
    final Status status,
    final DateTime startTime,
    final DateTime endTime,
  ) {
    final newTask = Objective(
        id: id,
        date: date,
        recurring: recurring,
        title: title,
        deviceId: deviceId,
        status: status,
        startTime: startTime,
        endTime: endTime);

    setState(() {
      _currentObjectives.add(newTask);
    });
  }

  int isPage = 0;

  void changePage(int index) {
    setState(() {
      isPage = index;
    });
  }

  Widget get openPage {
    if (isPage == 0) {
      return HomePage(_currentObjectives);
    } else if (isPage == 1) {
      return AddTaskBody(_addTask, _currentObjectives);
    } else if (isPage == 2) {
      return TestPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget curveNavBar = CurvedNavigationBar(
        height: 56,
        backgroundColor: Colors.orange,
        items: <Widget>[
          Icon(Icons.list, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.tune, size: 30),
        ],
        onTap: (index) => changePage(index)

        // {
        //   if (index == 1) {
        //     Navigator.of(context).pushNamed('/addtask', arguments: _addTask);
        //   }
        // },
        );

    return Scaffold(
      bottomNavigationBar: curveNavBar,
      body: openPage,
    );
  }
}
