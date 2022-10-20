import 'package:flutter/material.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';

void main() {
  runApp( MyApp());
}
const double defaultPadding = 5.0;
final CountDownTimer timer = CountDownTimer();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );}

  void emptyMethod() {}
}


class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final List<PopupMenuItem<String>> menuItems = [PopupMenuItem(value: 'Settings',child: Text('Settings'))];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My work timer'),
            actions: [
              PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                  return menuItems.toList();
                  },
                  onSelected: (s) {
                     if(s=='Settings') {
                        goToSettings(context);
                      }
                  }
              )]
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double availableWidth = constraints.maxWidth;
              return Column(children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(defaultPadding),),

                    Expanded(
                        child: ProductivityButton(color: Color(0xffec156f),
                            text: 'Work',
                            size: 150,
                            onPressed:  () => timer.startWork())),

                    Padding(padding: EdgeInsets.all(defaultPadding),),

                    Expanded(
                        child: ProductivityButton(color: Color(0xff607D8B),
                            text: 'Short Break',
                            size: 150,
                            onPressed:  () => timer.startBreak(true))),

                    Padding(padding: EdgeInsets.all(defaultPadding),),

                    Expanded(
                        child: ProductivityButton(color: Color(0xff455A64),
                            text: 'Long Break',
                            size: 150,
                            onPressed:() => timer.startBreak(false))),

                    Padding(padding: EdgeInsets.all(defaultPadding),),
                  ],
                ),

                Expanded(
                child: StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00') ? TimerModel('00:00', 1) : snapshot.data;
                    return Expanded(
                       child: CircularPercentIndicator(
                         radius: availableWidth / 4,
                         lineWidth: 10.0,
                         percent: timer.percent,
                         center: Text( timer.time, style: Theme.of(context).textTheme.headline4),
                         progressColor: Color(0xff009688),
                      ));
                  })),

                Row(children: [
                  Padding(padding: EdgeInsets.all(defaultPadding),),

                  Expanded(child: ProductivityButton(color: Color(0xffec156f),
                      text: 'Stop', size: 150, onPressed:  () => timer.stopTimer())),

                  Padding(padding: EdgeInsets.all(defaultPadding),),

                  Expanded(child: ProductivityButton(color: Color(0xff009688),
                      text: 'Restart', size: 150, onPressed:  () => timer.startTimer())),

                  Padding(padding: EdgeInsets.all(defaultPadding),),
                ],
                )

              ]
              );
            }
        )
    );
  }
  void emptyMethod() {}
  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>
        SettingsScreen()));
  }
}


