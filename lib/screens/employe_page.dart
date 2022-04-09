import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Row(
            children: [
              Text('Log Starting Time'),
              TimePickerDialog(initialTime: TimeOfDay.now()),
              Opacity(
                opacity: 0.4,
                child: Row(
                  children: [
                    const Text('Log End Time'),
                    TimePickerDialog(initialTime: TimeOfDay.now())
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
