import 'package:change/entity/User.dart';
import 'package:flutter/material.dart';

import 'AddPerformance.dart';

class PerformanceStatisticPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PerformanceStatisticState();
  }
}

class PerformanceStatisticState extends State {
  List<User> userList = [

  ];
  User? currUser = null;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.orange,cursorColor: Colors.orange),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("营业额统计"),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new AddPerformance()));

            }, icon: Icon(Icons.add)),
            IconButton(onPressed: () {

            }, icon: Icon(Icons.share)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                FlatButton(
                  onPressed: onPreClick,
                  child: Text("前一个"),
                  textColor: Colors.orange,
                ),
                Expanded(child: Center(child: Text("19-03"))),
                FlatButton(
                  onPressed: onNextClick,
                  child: Text("下一个"),
                  textColor: Colors.orange,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
              child: Text(
                "工号",
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void onPreClick() {}

  void onNextClick() {}
}
