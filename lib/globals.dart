library my_prj.globals;

DateTime get mondayIndex {
  var foo = 1;
  var monday = DateTime(2020, 7, 25);

  while (monday.weekday != foo) {
    monday = monday.subtract(Duration(days: 1));
  }
  return monday;
}

// return List.generate(7, (index) {
//   int complete = 0;
//   int incomplete = 0;
//   int indef = 0;
//   // print(inTasks[index]);
//   for (var s = 0; s < inTasks[index].length; s++) {
//     print(inTasks[index][s]);
//     if (inTasks[s]['status'] == 'INDEF') {
//       indef++;
//     }
//     if (inTasks[s]['status'] == 'COMPLETE') {
//       complete++;
//     }
//     if (inTasks[s]['status'] == 'INCOMPLETE') {
//       incomplete++;
//     }
//   }

//   return {
//     'date': DateFormat.E().format(dates[index]).substring(0, 1),
//     'incomplete': incomplete,
//     'complete': complete,
//     'indef': indef
//   };
// }).toList();
// print('InTasks ---- $inTasks');
// print(inTasks.runtimeType);
// print(inTasks.length);
