import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeekViewBar extends StatelessWidget {
  final String date;
  final int comp;
  final int incomp;
  final int indef;

  WeekViewBar({
    this.comp,
    this.date,
    this.incomp,
    this.indef,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(
            top: 20,
            left: 7,
          ),
          height: 60,
          width: 26,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Column(
                children: <Widget>[
                  ...List.generate(comp, (index) {
                    return Container(
                      margin: EdgeInsets.only(left: 2, top: 5),
                      width: 22,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(),
                        color: Colors.blue,
                      ),
                    );
                  }).toList(),
                  ...List.generate(incomp, (index) {
                    return Container(
                      margin: EdgeInsets.only(left: 2, top: 5),
                      width: 22,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                        color: Colors.red,
                      ),
                    );
                  }).toList(),
                  ...List.generate(indef, (index) {
                    return Container(
                      margin: EdgeInsets.only(left: 2, top: 5),
                      width: 22,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(),
                        color: Colors.grey,
                      ),
                    );
                  }).toList()
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.only(left: 8),
          width: 22,
          height: 15,
          child: Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
