import 'package:flutter/material.dart';

import 'PerformanceStatisticPage.dart';

/// 主界面
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 70,
              child: FlatButton(
                  textColor: Colors.orange,
                  child: Text("营业额记录 >"),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new PerformanceStatisticPage())); // 跳转到业绩、工资统计界面
                  }),
            ),
            Divider(
              height: 1,
              indent: 1,
            ),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: FlatButton(
                  textColor: Colors.blue,
                  child: Text("收支记录 >"),
                  onPressed: () {
                    // todo 跳转到收支记录中
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
