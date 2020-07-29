import 'package:flutter/material.dart';

class WeeklyTaskList extends StatelessWidget {
  final Color color;
  final List weeklyObj;
  WeeklyTaskList(this.weeklyObj, this.color);

  List get _currentObjectives {
    List foo = [];
    if (weeklyObj.length == 7) {
      for (int i = 0; i < 7; i++) {
        // print('Weekly Layer 1 $i ----- ${weeklyObj[i]}');
        if (weeklyObj[i].length >= 1) {
          for (int a = 0; a < weeklyObj[i].length; a++) {
            // print('Weekly Layer 2 $i - $a ----- ${weeklyObj[i][a]}');
            foo.add(weeklyObj[i][a]);
          }
        }
        // else {
        //   print(weeklyObj[i].length);
        // }
      }

      // print('--------------------');
    } else {
      foo.add(weeklyObj[0]);
    }
    return foo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Container(
              height: 65,
              child: Card(
                elevation: 6,
                color: color,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  border: Border.all(), shape: BoxShape.circle),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _currentObjectives[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text('Computer', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          },
          itemCount: _currentObjectives.length),
    );
  }
}
