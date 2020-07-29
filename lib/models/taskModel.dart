import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

DateTime get mondayIndex {
  var foo = 1;
  var monday = DateTime(2020, 7, 25);

  while (monday.weekday != foo) {
    monday = monday.subtract(Duration(days: 1));
  }
  return monday;
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

Future<List> getToday(DateTime date) async {
  var params = {'date': date.toIso8601String().substring(0, 10)};
  Uri uri = Uri.parse('http://45.33.31.137:5000/task/recursive');
  final newURI = uri.replace(queryParameters: params);
  http.Response response = await http.get(
    newURI,
    headers: {"Accept": "application/json"},
  );

  List inTasks = json.decode(response.body);
  // print(inTasks);

  return inTasks;
}

Future<List> getCompRatio(DateTime date) async {
  List inTasks = [];
  List dates = [];
  List<Map> maps = [];

  for (var a = 0; a < 7; a++) {
    dates.add(date.add(Duration(days: a)));
  }
  for (var i = 0; i < 7; i++) {
    var params = {'date': dates[i].toIso8601String().substring(0, 10)};
    Uri uri = Uri.parse('http://45.33.31.137:5000/task/recursive');
    final newURI = uri.replace(queryParameters: params);
    http.Response response = await http.get(
      newURI,
      headers: {"Accept": "application/json"},
    );
    var res = json.decode(response.body);
    inTasks.add(res);
    // print('${dates[i].weekday} ${dates[i]} --- $res');
    // date = date.add(Duration(days: i));
  }
  // print(inTasks);

  // print(dates);
  int goo = 0;
  for (int foo = 0; foo < 7; foo++) {
    int complete = 0;
    int incomplete = 0;
    int indef = 0;
    // print('Layer 1 ---- $foo');
    for (int da = 0; da < inTasks[foo].length; da++) {
      // print('Layer 2 ---- $da');
      if (inTasks[foo][da]['status'] == 'INDEF') {
        indef++;
      } else if (inTasks[foo][da]['status'] == 'COMPLETE') {
        complete++;
      } else if (inTasks[foo][da]['status'] == 'INCOMPLETE') {
        incomplete++;
      }
    }
    // print(dates[goo]);

    maps.add({
      'date': DateFormat.E().format(dates[goo]).substring(0, 1),
      'incomplete': incomplete,
      'complete': complete,
      'indef': indef
    });
    goo++;
  }
  // print(maps);
  return maps;
}

Future<List> getWeekly(DateTime date) async {
  List tasks = [];
  List dates = [];

  for (var a = 0; a < 7; a++) {
    dates.add(date.add(Duration(days: a)));
  }
  for (var i = 0; i < 7; i++) {
    var params = {'date': dates[i].toIso8601String().substring(0, 10)};
    Uri uri = Uri.parse('http://45.33.31.137:5000/task/recursive');
    final newURI = uri.replace(queryParameters: params);
    http.Response response = await http.get(
      newURI,
      headers: {"Accept": "application/json"},
    );
    var res = json.decode(response.body);
    tasks.add(res);
    // print('${dates[i].weekday} ${dates[i]} --- $res');
    // date = date.add(Duration(days: i));
  }
  // print(inTasks);
  return tasks;
}
