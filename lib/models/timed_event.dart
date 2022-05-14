class TimedEvent {
  final int id;
  final String title;
  final String time;
  final bool active;
  final String startTime;

  TimedEvent({
    required this.id,
    required this.title,
    required this.time,
    required this.active,
    required this.startTime,
  });

  static Map<String, dynamic> toMap(TimedEvent event) => {
        'id': event.id,
        'title': event.title,
        'time': event.time,
        'active': event.active,
        'startTime': event.startTime,
      };

  factory TimedEvent.fromJson(jsonData) {
    return TimedEvent(
      id: jsonData['id'],
      title: jsonData['title'],
      time: jsonData['time'],
      active: jsonData['active'],
      startTime: jsonData['startTime'],
    );
  }

  TimedEvent copyWith({String? title, bool? active, String? time}) {
    return TimedEvent(
      id: id,
      title: title ?? this.title,
      time: time ?? this.time,
      active: active ?? this.active,
      startTime: startTime,
    );
  }
}
