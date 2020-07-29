import 'package:Tracker_app/models/taskModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import '../models/objective.dart';
import '../models/taskModel.dart';
import '../widgets/picker.dart';
import '../globals.dart' as globals;
import '../widgets/weeklyTaskList.dart';

class AddTaskBody extends StatefulWidget {
  final List _currentObjectives;
  final Function submitData;
  AddTaskBody(this.submitData, this._currentObjectives);

  @override
  _AddTaskBodyState createState() =>
      _AddTaskBodyState(submitData, _currentObjectives);
}

class _AddTaskBodyState extends State<AddTaskBody> {
  final dependController = TextEditingController();
  final titleController = TextEditingController();
  DateTime _selectedDate;
  final List _currentObjectives;

  final Function _submitData;
  _AddTaskBodyState(this._submitData, this._currentObjectives);

  void _startDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    ).then((dateValue) {
      if (dateValue == null) {
        return;
      }
      setState(() {
        _selectedDate = dateValue;
      });
    });
  }

  void submitData() {
    if (titleController.text.isEmpty) {
      return;
    }
    final String dependData = dependController.text;
    final String titleData = titleController.text;

    if (titleData.isEmpty || dependData.isEmpty || _selectedDate == null) {
      return;
    }
    _submitData(_selectedDate, dependData, titleData, Status.Indef);
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return Pickers();
        });
  }

  @override
  Widget build(BuildContext context) {
    // final Function _submitData =
    //     ModalRoute.of(context).settings.arguments as Function;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.orange,
            width: 400,
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kBottomNavigationBarHeight) *
                1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Container(
                  width: 350,
                  height: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[600],
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        width: 300,
                        child: TextField(
                            decoration: InputDecoration(labelText: 'Task'),
                            controller: titleController),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 300,
                        child: TextField(
                            decoration: InputDecoration(labelText: 'Depend'),
                            controller: dependController),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _selectedDate == null
                                      ? 'No Date Chosen'
                                      : 'Picked Date: \n ${DateFormat.yMd().format(_selectedDate)}',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                  onPressed: _startDatePicker,
                                  child: Text('Add Date'),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: 300,
                            child: RaisedButton(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                color: Colors.deepOrange,
                                onPressed: () => _startAddTransaction(context)),
                            // submitData),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 218,
                    width: 350,
                    child: FutureBuilder(
                        future: getWeekly(globals.mondayIndex),
                        builder: (context, AsyncSnapshot snapshot) {
                          print('WEEKLY TASK ------ ${snapshot.data}');
                          return snapshot.data != null
                              ? WeeklyTaskList(
                                  snapshot.data.toList(), Colors.white)
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
