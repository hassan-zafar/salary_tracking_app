import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/timer_service.dart';



class PauseButton extends StatelessWidget {
  const PauseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isActive = context.watch<TimerService>().timerActive;

    return InkWell(
      onTap: () {
        if (isActive) {
          context.read<TimerService>().stop();
        } else {
          context.read<TimerService>().addNew();
        }
        // Navigator.of(context).pop();
      },
      child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            isActive ? Icons.stop : Icons.play_arrow,
            size: 40,
            color: Colors.white,
          )),
    );
  }
}
