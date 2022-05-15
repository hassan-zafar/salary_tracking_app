import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salary_tracking_app/models/timed_event.dart';
import 'package:salary_tracking_app/services/timer_service.dart';

class EventItem extends StatelessWidget {
  final TimedEvent event;

  const EventItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(event.id.toString()),
      confirmDismiss: (direction) async {
        if (event.active) return false;
        return true;
      },
      onDismissed: (direction) {
        context.read<TimerService>().delete(event.id);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(event.title),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  constraints: BoxConstraints(maxHeight: 25, maxWidth: 25),
                  onPressed: () async {
                    _controller.text = event.title;
                    var result = await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Edit title',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextField(
                                    controller: _controller,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () {
                                            String inputText = _controller.text;
                                            if (inputText.isEmpty) return;
                                            Navigator.pop(
                                                context, inputText.trim());
                                          },
                                          child: Text('Save')),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });

                    if (result != null) {
                      context.read<TimerService>().edit(event.id, result);
                    }
                  },
                  icon: Icon(
                    event.active ? Icons.access_time : Icons.edit,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(height: 5),
                Text(event.active
                    ? context.watch<TimerService>().currentTime
                    : event.time),
              ],
            )
          ],
        ),
      ),
    );
  }
}
