import 'package:flutter/material.dart';

class Pickers extends StatefulWidget {
  @override
  _PickersState createState() => _PickersState();
}

class _PickersState extends State<Pickers> {
  List dayPicker = [
    'Monday',
    'Tuesday',
    'Wendsday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List frequency = [
    'Weekly',
    'Monthly',
    'Bi-Weekly',
    'All Weekdays',
    'All Weekends',
    'Every Other Day',
  ];

  @override
  Widget build(BuildContext context) {
    Color avaColor = Colors.black;
    void ChangeColor() {
      setState(() {
        avaColor = Colors.red;
      });
    }

    return Container(
      width: double.infinity,
      height: 300,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, left: 5, right: 5),
            width: 345 / 3,
            height: 270,
            child: ListView.builder(
                itemCount: dayPicker.length,
                itemBuilder: (ctx, index) {
                  return Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 100,
                      height: 40,
                      child: InkWell(
                        onTap: ChangeColor,
                        splashColor: Colors.red,
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Text(dayPicker[index]),
                              CircleAvatar(
                                backgroundColor: avaColor,
                                radius: 10,
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 5, right: 5),
            width: 345 / 3,
            height: 270,
            child: ListView.builder(
                itemCount: frequency.length,
                itemBuilder: (ctx, index) {
                  return Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 100,
                      height: 40,
                      child: InkWell(
                        onTap: ChangeColor,
                        splashColor: Colors.red,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  frequency[index],
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: avaColor,
                                radius: 7,
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 5, right: 5),
            width: 345 / 3,
            height: 270,
            child: ListView.builder(
                itemCount: 7,
                itemBuilder: (ctx, index) {
                  return Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 100,
                      height: 40,
                      child: InkWell(
                        onTap: ChangeColor,
                        splashColor: Colors.red,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Text('data'),
                              SizedBox(
                                width: 35,
                              ),
                              CircleAvatar(
                                backgroundColor: avaColor,
                                radius: 15,
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
