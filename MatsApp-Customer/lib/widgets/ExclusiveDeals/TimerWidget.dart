import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/size_config.dart';

class TimerWidget extends StatefulWidget {
  final endDate, endTime;
  TimerWidget(this.endDate, this.endTime, {Key key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds, minutes, hours1 = 0;

  int days;
  @override
  void initState() {
    super.initState();
    //datetimecalcu("2021/06/30", "15:35:00");
    datetimecalcu(widget.endDate, widget.endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: hours1 <= 24
            ? hours1 != null
                ? TweenAnimationBuilder<Duration>(
                    duration: Duration(
                        hours: hours1 ?? 0,
                        minutes: minutes ?? 0,
                        seconds: seconds ?? 0),
                    tween: Tween(
                        begin: Duration(
                            hours: hours1 ?? 0,
                            minutes: minutes ?? 0,
                            seconds: seconds ?? 0),
                        end: Duration.zero),
                    onEnd: () {
                      print('Timer ended');
                    },
                    builder:
                        (BuildContext context, Duration value, Widget child) {
                      int hrs = value.inHours ?? 0;
                      int minutes = value.inMinutes % 60 ?? 0;
                      int seconds = value.inSeconds % 60 ?? 0;
                      return hrs != 0 || minutes != 0 || seconds != 0
                          ? Text('Ends in $hrs:$minutes:$seconds',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.kSecondaryDarkColor,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: SizeConfig.heightMultiplier * 1.6))
                          : Container();
                    })
                : Container()
            : days != null
                ? Container(
                    child: Text("Ends in\r$days\rdays",
                        style: TextStyle(
                            color: AppColors.kSecondaryDarkColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            fontSize: SizeConfig.heightMultiplier * 1.6)))
                : Container());
  }

  void datetimecalcu(String date, String time) {
    var splitdateEnd = date.split('/');

    int yearend = int.parse(splitdateEnd[0]);
    int monthend = int.parse(splitdateEnd[1]);
    int dayend = int.parse(splitdateEnd[2]);
    var num1 = 10.12345678;
    var f = new NumberFormat("##", "en_US");
    // print(f.format(yearend));

    //print("Endtime:$monthend");
    //print("Endtime:$dayend");

    ///Split Time //////////////////////////////////////////////////////
    String endTime1 = time;
    var splitEndtTime = endTime1.split(':');

    int endTimeHour = int.parse(splitEndtTime[0]);
    int endTimeMinutes = int.parse(splitEndtTime[1]);
    int endTimeSeconds = int.parse(splitEndtTime[2]);
    // print("Endtime hrs:$endTimeHour");
    // print("Endtime min:$endTimeMinutes");
    // print("Endtime sec:$endTimeSeconds");

    final endTime = DateTime(
        yearend, monthend, dayend, endTimeHour, endTimeMinutes, endTimeSeconds);
    if (DateTime.now().isBefore(endTime)) {
      if (mounted) {
        setState(() {
          hours1 = endTime.difference(DateTime.now()).inHours % 60 ?? 0;
          minutes = endTime.difference(DateTime.now()).inMinutes % 60 ?? 0;
          seconds = endTime.difference(DateTime.now()).inSeconds % 60 ?? 0;
          days = endTime.difference(DateTime.now()).inDays;
          if (hours1 <= 24) {}

          // print("Hours$hours1");
          // print("minutes$minutes");
          // print("seconds$seconds");
        });
      }
    }
  }
}
