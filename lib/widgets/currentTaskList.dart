import 'package:flutter/material.dart';

class CurrentTaskList extends StatelessWidget {
  final Color color;
  final List _currentObjectives;
  CurrentTaskList(this._currentObjectives, this.color);

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
