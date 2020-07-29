import 'package:Tracker_app/models/taskModel.dart';
import 'package:flutter/material.dart';
import '../widgets/weekView.dart';
import '../widgets/currentTaskList.dart';
import '../globals.dart' as globals;

class HomePage extends StatelessWidget {
  final List _currentObjectives;

  HomePage(this._currentObjectives);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kBottomNavigationBarHeight) *
                0.28,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 2))
              ],
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          'Today',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${2} Tasks',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FutureBuilder(
                      future: getToday(DateTime(2020, 7, 24)),
                      builder: (context, AsyncSnapshot snapshot) {
                        print('DAILY TASK ------ ${snapshot.data}');
                        return snapshot.data != null
                            ? CurrentTaskList(
                                snapshot.data, Colors.orangeAccent)
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        kBottomNavigationBarHeight) *
                    .02,
              ),
              Column(children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          kBottomNavigationBarHeight -
                          0) *
                      0.7,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 5))
                    ],
                    color: Colors.orange,
                    // border: Border.all(),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: getCompRatio(globals.mondayIndex),
                        builder: (context, AsyncSnapshot snapshot) {
                          // print(snapshot.data);
                          return snapshot.data != null
                              ? WeekView(
                                  (MediaQuery.of(context).size.height -
                                          MediaQuery.of(context).padding.top -
                                          kBottomNavigationBarHeight) *
                                      0.7,
                                  snapshot.data)
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
