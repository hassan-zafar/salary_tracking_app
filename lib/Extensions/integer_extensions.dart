class ParsedTime {
  late int years;
  late int months;
  late int days;
  late int hours;
  late int minutes;
  late int seconds;
  late String sign;
  ParsedTime(int sec) {
    sign = sec < 0 ? '-' : '';
    years = (sec.abs() / 31536000).floor();               // years
    months = ((sec.abs() / 2592000) % 2592000).floor();   // months
    days = ((sec.abs() / 86400) % 86400).floor();         // days
    hours = ((sec.abs() / 3600) % 3600).floor();          // hours
    minutes = ((sec.abs() / 60) % 60).floor();            // minutes
    seconds = (sec.abs() % 60).floor();                   // seconds
  }

  String get hoursZero => hours < 10 ? '0' + hours.toString() : hours.toString();

  String get minutesZero => minutes < 10 ? '0' + minutes.toString() : minutes.toString();

  String get secondsZero => seconds < 10 ? '0' + seconds.toString() : seconds.toString();
}
extension IntExtensions on int {
  String get formatSecondsToTime {
    var parsedTime = ParsedTime(this);
    return "${parsedTime.sign}${parsedTime.hoursZero}:${parsedTime.minutesZero}:${parsedTime.secondsZero}";
  }

  String get formatSecondsToTimeWithFormat {
    var parsedTime = ParsedTime(this);
    if (parsedTime.years > 0) {
      return "${parsedTime.sign}${parsedTime.years} year(s)";
    }
    if (parsedTime.months > 0) {
      return "${parsedTime.sign}${parsedTime.months} month(s)";
    }
    if (parsedTime.days > 1) {
      return "${parsedTime.sign}${parsedTime.days} day(s)";
    }
    if (parsedTime.hours == 0 && parsedTime.minutes == 0) {
      return "${parsedTime.hoursZero}h:${parsedTime.minutesZero}m";
    }
    return "${parsedTime.sign}${parsedTime.hoursZero}h:${parsedTime.minutesZero}m";
  }
  String get formatSecondsToTimeWithHrMinFormat {
    var parsedTime = ParsedTime(this);
    if (parsedTime.years > 0) {
      return "${parsedTime.sign}${parsedTime.years} year(s)";
    }
    if (parsedTime.months > 0) {
      return "${parsedTime.sign}${parsedTime.months} month(s)";
    }
    if (parsedTime.days > 1) {
      return "${parsedTime.sign}${parsedTime.days} day(s)";
    }
    if (parsedTime.hours == 0 && parsedTime.minutes == 0) {
      return "${parsedTime.minutesZero}m";
    }
    if (parsedTime.hours == 0) {
      return "${parsedTime.sign}${parsedTime.minutesZero}m";
    }
    return "${parsedTime.sign}${parsedTime.hoursZero}h:${parsedTime.minutesZero}m";
  }

  String get formatSecondsToTimeWithRoundedSecondsToMinutes {
    if ((this.abs() % 60).floor() > 0) {//in case we have non 0 seconds
      if (this<0) {
        return (this-60).formatSecondsToTimeWithFormat;
      } else {
        return (this + 60).formatSecondsToTimeWithFormat;
      }
    }
    return this.formatSecondsToTimeWithFormat;
  }


  String get formatSecondsToTimeWithPreciseFormat {
    var parsedTime = ParsedTime(this);
    if(parsedTime.hours == 0) {
      if (parsedTime.minutes == 0) {
        return "${parsedTime.minutesZero}m";
      }
      return "${parsedTime.sign}${parsedTime.minutesZero}m";
    }
    return "${parsedTime.sign}${parsedTime.hours}h:${parsedTime.minutesZero}m";
  }


  String get formatSecondsToTimeWithoutZero {
    dynamic hh = (this.abs() / 3600).floor();
    dynamic mm = ((this.abs() / 60) % 60).floor();
    if (mm < 10) {
      mm = '0' + mm.toString();
    }
    return (this < 0 ? '-' : '') + hh.toString() + ':' + mm.toString();
  }

  String secondsToTimeLeft() {
    var leftTime = this.toDouble();
    if (leftTime < 0) {
      return 'no time';
    }
    if (leftTime <= 60) {
      return 'less than a minute';
    }

    var hours = (leftTime / 3600).floor();
    leftTime %= 3600;
    var minutes = (leftTime / 60).round();

    var msgHours = hours == 1 ? '$hours hour' : '$hours hours';
    var msgMinutes = minutes == 1 ? '$minutes minute' : '$minutes minutes';

    if (hours > 0 && minutes > 0) {
      return '$msgHours $msgMinutes';
    }

    if (hours > 0) {
      return msgHours;
    }

    return msgMinutes;
  }
}
