import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

final DummyObjectives = [
  Objective(
    id: '4',
    date: DateTime(2020, 7, 24),
    recurring: null,
    title: 'Work',
    deviceId: '1',
    status: Status.Indef,
    startTime: DateTime(2020, 7, 28),
    endTime: DateTime(2020, 7, 29),
  )
];

Recurring recurringParse(String recString) {
  if (recString == 'null') {
    return null;
  } else if (recString == 'WEEKLY') {
    return Recurring.Weekly;
  } else if (recString == 'MONTHLY') {
    return Recurring.Monthly;
  }
}

Status statusParse(String statString) {
  if (statString == 'INDEF') {
    return Status.Indef;
  } else if (statString == 'COMPLETE') {
    return Status.Complete;
  } else if (statString == 'INCOMPLETE') {
    return Status.Incomplete;
  }
  ;
}

Future<List> getDailyTask(DateTime date) async {
  var params = {'date': date.toIso8601String()};
  Uri uri = Uri.parse('http://45.33.31.137:5000/task/recursive');
  final newURI = uri.replace(queryParameters: params);
  http.Response response = await http.get(
    newURI,
    headers: {"Accept": "application/json"},
  );

  List inTasks = json.decode(response.body);

  List dailyTasks = [];
  for (var i = 0; i < inTasks.length; i++) {
    Objective newTask = Objective(
        id: inTasks[i]['id'],
        date: DateTime.parse(inTasks[i]['date']),
        recurring: recurringParse(inTasks[i]['recurring']),
        title: inTasks[i]['title'],
        deviceId: inTasks[i]['device_id'],
        status: statusParse(inTasks[i]['status']),
        startTime: DateTime.parse(inTasks[i]['start_time']),
        endTime: DateTime.parse(inTasks[i]['end_time']));
    dailyTasks.add(newTask);
    // print('Getting Task ${i}');
  }
  // print(dailyTasks.length);
  return dailyTasks;
}

List get thisWeeksTasks {
  return List.generate(7, (index) {
    var indexDate = DateTime(2020, 7, 24 + index);
    Future<List> indexDateTask = getDailyTask(indexDate);
    return indexDateTask;
  }).toList();
}

void debug() {
  print('grabbing WeekTask length');
  print(thisWeeksTasks.length);
  print(weeklyCompRatio[0]['date']);
}

DateTime get mondayIndex {
  var foo = 1;
  var monday = DateTime.now();

  while (monday.weekday != foo) {
    monday = monday.subtract(Duration(days: 1));
  }
  return monday;
}

// List<List<Objective>> get getWeeklyTask {
//   int foo = 7;
//   List weekTask = [];
//   while (mondayIndex.weekday != foo) {
//     weekTask.add(getDailyTask(mondayIndex));
//     mondayIndex.add(Duration(days: 1));
//     sleep(Duration(seconds: 4));
//   }
//   print(weekTask.length);
//   return weekTask;
// }

List<Map> get weeklyCompRatio {
  List compList = [];

  //// CHeck this
  for (var i = 0; i < thisWeeksTasks.length; i++) {
    ////
    int complete = 0;
    int incomplete = 0;
    int indef = 0;
    for (var a = 0; a < thisWeeksTasks[i].length; i++) {
      if (thisWeeksTasks[i][a].status == Status.Complete) {
        complete++;
      } else if (thisWeeksTasks[i][a].status == Status.Incomplete) {
        complete++;
      } else if (thisWeeksTasks[i][a].status == Status.Indef) {
        indef++;
      }
    }
    Map compMap = {
      'date': DateFormat.E().format(thisWeeksTasks[i].date).substring(0, 1),
      'incomplete': incomplete,
      'complete': complete,
      'indef': indef
    };
    compList.add(compMap);
  }
  return compList;
}

// List get weekComRatio {
//   List weeksList = [];
//   for (var i = 0; i < getWeeklyTask.length; i++) {
//     getWeeklyTask.add(weeksList[i]);
//   }

//   return List.generate(7, (index) {
//     final weekDay = mondayIndex.add(
//       Duration(days: index),
//     );
//     int complete = 0;
//     int incomplete = 0;
//     int indef = 0;
//     for (var a = 0; a < weeksList[a].length; a++) {
//       if (weeksList[a].date.day == weekDay.day &&
//           weeksList[a].date.month == weekDay.month &&
//           weeksList[a].date.year == weekDay.year &&
//           weeksList[a].status == Status.Complete) {
//         complete++;
//       } else if (weeksList[a].date.day == weekDay.day &&
//           weeksList[a].date.month == weekDay.month &&
//           weeksList[a].date.year == weekDay.year &&
//           weeksList[a].status == Status.Incomplete) {
//         incomplete++;
//       } else if (weeksList[a].date.day == weekDay.day &&
//           weeksList[a].date.month == weekDay.month &&
//           weeksList[a].date.year == weekDay.year &&
//           weeksList[a].status == Status.Indef) {
//         indef++;
//       }
//     }
//     return {
//       'date': DateFormat.E().format(weekDay).substring(0, 1),
//       'incomplete': incomplete,
//       'complete': complete,
//       'indef': indef
//     };
//   }).toList();
// }

String isStatusString(Objective task) {
  if (task.status == Status.Indef) {
    return 'INDEF';
  } else if (task.status == Status.Complete) {
    return 'COMPLETE';
  } else if (task.status == Status.Incomplete) {
    return 'INCOMPLETE';
  }
  ;
}

String isReccuringString(Objective task) {
  if (task.recurring == null) {
    return 'null';
  } else if (task.recurring == Recurring.Weekly) {
    return 'WEEKLY';
  } else if (task.recurring == Recurring.Monthly) {
    return 'MONTHLY';
  }
}

Future<List> putData(Objective task) async {
  Map data = {
    'id': task.id,
    'title': task.title,
    'recurring': isReccuringString(task),
    'date': task.date.toIso8601String().substring(0, 10),
    'device_id': task.deviceId,
    'status': isStatusString(task),
    'start_time': task.startTime.toIso8601String().substring(0, 10),
    'end_time': task.endTime.toIso8601String().substring(0, 10),
  };
  http.Response response = await http.put(
      'http://45.33.31.137:5000/task/recursive',
      headers: {"Accept": "application/json"},
      body: data);
  print(response.body);
}

enum Status {
  Complete,
  Incomplete,
  Indef,
}
enum Recurring {
  Weekly,
  Monthly,
}

class Objective {
  final String id;
  final DateTime date;
  final Recurring recurring;
  final String title;
  final String deviceId;
  final Status status;
  final DateTime startTime;
  final DateTime endTime;

  const Objective({
    @required this.id,
    @required this.date,
    @required this.recurring,
    @required this.title,
    @required this.deviceId,
    @required this.status,
    @required this.startTime,
    @required this.endTime,
  });
}
