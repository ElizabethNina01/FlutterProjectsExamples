import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings'),),
        body:Settings()
    )
    ;
  }
}
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late int workTime;
  late int shortBreak;
  late int longBreak;
  late SharedPreferences prefs;

  TextStyle textStyle = TextStyle(fontSize: 24);
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            Text("Work", style: textStyle),
            Text(""),
            Text(""),
            SettingButton(color: Color(0xff455A64), text: '-', value: -1, setting: 'updateSetting', size: 50, callback: (String , int ) {  },),
            TextField(
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: txtWork
            ),
            SettingButton(color: Color(0xff009688), text: '+', value:1,setting: 'updateSetting', size: 50, callback: (String , int ) {  },),
                Text("Short", style: textStyle),
            Text(""),
            Text(""),
            SettingButton(color: Color(0xff455A64), text: '-', value:-1, setting: 'updateSetting', size: 50, callback: (String , int ) {  },),
            TextField(
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: txtShort,
            ),
            SettingButton(color:Color(0xff009688), text: '+', value:1, setting: 'updateSetting', size: 50, callback: (String , int ) {  },),
            Text("Long", style: textStyle,),
            Text(""),
            Text(""),
            SettingButton(color:Color(0xff455A64), text:'-',value: -1, setting: 'updateSetting', size: 50, callback: (String , int ) {  },),
            TextField(
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: txtLong,
            ),
            SettingButton(color:Color(0xff009688), text:'+',value:1, setting: 'updateSetting', size: 50, callback: (String , int ) {  },),],
          padding: const EdgeInsets.all(20.0),
        )
    );
  }
  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME)!;
    if (workTime==null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int shortBreak = prefs.getInt(SHORTBREAK)!;
    if (shortBreak==null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int longBreak = prefs.getInt(LONGBREAK)!;
    if (longBreak==null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }
  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME: {
        int workTime = prefs.getInt(WORKTIME)!;
        workTime += value;
        if (workTime >= 1 && workTime <= 180) {
          prefs.setInt(WORKTIME, workTime);
          setState(() {txtWork.text = workTime.toString();});
        }
      } break;
      case SHORTBREAK: {
        int short = prefs.getInt(SHORTBREAK)!;
        short += value;
        if (short >= 1 && short <= 120) {
          prefs.setInt(SHORTBREAK, short);
          setState(() { txtShort.text = short.toString(); });
        }
      } break;
      case LONGBREAK:{
        int long = prefs.getInt(LONGBREAK)!;
        long += value;
        if (long >= 1 && long <= 180) {
          prefs.setInt(LONGBREAK, long);
          setState(() { txtLong.text = long.toString();});
        }
      } break;
    }
  }

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

}

