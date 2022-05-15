import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers.dart';
import '../models/timed_event.dart';
import '../services/timer_service.dart';

class HeaderTimer extends StatelessWidget {
  const HeaderTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool timerActive = context.watch<TimerService>().timerActive;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(5),
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            PauseButton(),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (timerActive) ...[
                  Builder(builder: (context) {
                    TimedEvent event =
                        context.watch<TimerService>().activeEvent;
                    DateTime startTime = DateTime.parse(event.startTime);
                    String h = padNumber(startTime.hour);
                    String m = padNumber(startTime.minute);
                    String s = padNumber(startTime.second);
                    String startTimeString = "$h:$m:$s";

                    return Text('CLOCK STARTED AT $startTimeString');
                  })
                ] else ...[
                  Text('NO ACTIVE TIMER'),
                ],
                SizedBox(height: 5),
                Expanded(
                  child: Text(
                    timerActive
                        ? context.watch<TimerService>().currentTime
                        : '00:00:00',
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.w200,
                      height: 1,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
        Navigator.of(context).pop();
      },
      child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            isActive ? Icons.pause : Icons.play_arrow,
            size: 40,
            color: Colors.white,
          )),
    );
  }
}
