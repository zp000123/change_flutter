import 'package:change/entity/User.dart';
import 'package:flutter/material.dart';

import 'AddPerformance.dart';
/// 业绩工资记录统计界面
class PerformanceStatisticPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PerformanceStatisticState();
  }
}

class PerformanceStatisticState extends State {
  List<User> userList = [];
  User? currUser;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.orange,cursorColor: Colors.orange),
      child: Scaffold(
        appBar: AppBar(
          title: Text("营业额统计"),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new AddPerformance())); // 跳转到添加业绩、工资记录界面
            }, icon: Icon(Icons.add)),
            IconButton(onPressed: () {

            }, icon: Icon(Icons.share)),
          ],
        ),
        body: Theme(data: ThemeData(primarySwatch: Colors.orange),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  TextButton(
                    onPressed: onPreClick,
                    child: Text("前一个"),
                  ),
                  Expanded(child: Center(child: Text("19-03"))),
                  TextButton(
                    onPressed: onNextClick,
                    child: Text("下一个"),
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
        ),
      ),
    );
  }

  void onPreClick() {}

  void onNextClick() {}
}
