import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salary_tracking_app/models/timed_event.dart';
import 'package:salary_tracking_app/services/timer_service.dart';
import 'package:salary_tracking_app/widgets/event_item.dart';

class EventList extends StatelessWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerService timerService = context.watch<TimerService>();

    List<TimedEvent> timedEvents = timerService.timedEvents;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemCount: timedEvents.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      timerService.addNew();
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 35,
                      color: context.watch<TimerService>().timerActive
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return EventItem(event: timedEvents[index - 1]);
          }
        },
      ),
    );
  }
}
