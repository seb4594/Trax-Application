import 'package:flutter/material.dart';
// import '../models/taskModel.dart';
import '../models/objective.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST'),
      ),
      body: Container(
        height: 400,
        width: 400,
        child: Column(
          children: <Widget>[
            Container(
              width: 400,
              height: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Get'),
                    onPressed: () {
                      getDailyTask(DateTime(2020, 7, 24));
                    },
                  ),
                  RaisedButton(
                    child: Text('Put'),
                    onPressed: () {
                      putData(DummyObjectives[0]);
                    },
                  ),
                  RaisedButton(
                    child: Text('Grab Week'),
                    onPressed: () {
                      putData(DummyObjectives[0]);
                    },
                  ),
                  RaisedButton(
                    child: Text('Debug'),
                    onPressed: () {
                      debug();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
