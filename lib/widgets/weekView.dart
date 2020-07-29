import 'package:Tracker_app/widgets/weekViewBar.dart';
import 'package:flutter/material.dart';
import '../models/objective.dart';

class WeekView extends StatelessWidget {
  final double containerSplit;
  final List<Map> weeklyObjectives;

  WeekView(this.containerSplit, this.weeklyObjectives);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      height: containerSplit * 0.33,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 5))
        ],
        color: Colors.white,
        // border: Border.all(),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(35),
            topRight: Radius.circular(0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weeklyObjectives.map((data) {
                return WeekViewBar(
                  date: data['date'],
                  comp: data['complete'],
                  incomp: data['incomplete'],
                  indef: data['indef'],
                );
              }).toList()

              // WeekViewBar(weeklyObjectives)

              )
        ],
      ),
    );
  }
}
