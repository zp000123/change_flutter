import 'package:change/data/Dao.dart';
import 'package:change/entity/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPerformance extends StatelessWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.orange),
      child: Scaffold(
        appBar: AppBar(
          title: Text("添加营业记录"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
        ),
        body: Theme(data: ThemeData(primarySwatch: Colors.orange),
            child: AddPerformanceBodyPage()),
      ),
    );
  }
}

/// 添加营业记录界面
class AddPerformanceBodyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPerformanceBodyPageState();

  DateTime dateTime = DateTime.now();
  List<User> userList = List.empty(growable: true);
  String? userName = null;
}

class _AddPerformanceBodyPageState extends State<AddPerformanceBodyPage> {
  @override
  void initState() {
    super.initState();
    getUsers().then((userList) {
      if (userList.isEmpty) return;
      setState(() {
        widget.userList.addAll(userList);
        if (widget.userName == null) {
          widget.userName = userList[0].name;
        }
      });
    });
  }

  void onPreClick() {
    setState(() {
      widget.dateTime = DateUtils.addDaysToDate(widget.dateTime, -1);
    });
  }

  void onNextClick() {
    setState(() {
      widget.dateTime = DateUtils.addDaysToDate(widget.dateTime, 1);
    });
  }

  /// 添加用户点击
  void addUserClick() async {
    User? user = await showDialog(
        context: context,
        builder: (BuildContext context) {
          var userNo = ""
          return AlertDialog(
              title: Text("添加工号"),
              content: TextField(

                autofocus: true,
                onChanged: (String s) {
                  userNo = s
                },
                decoration: InputDecoration(
                    hintText: "请输入新增的工号",
                    prefixIcon: Icon(Icons.person_add, ),
                    border: InputBorder.none),
              ),
              actions: [
               TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text("取消",)),
               TextButton(
                    onPressed: () {
                      Navigator.pop(context, User(name: userNo));
                    },
                    child: Text("确定")),
              ]);
        });
    if (user != null) {
      insertUser(user).then((id) {
        user.id = id;
        setState(() {
          widget.userName = user.name;
          widget.userList.add(user);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            TextButton(
              onPressed: onPreClick,
              child: Text("前一个"),
            ),
            Expanded(
                child: Center(
                    child: Text(
                        "${widget.dateTime.year}-${widget.dateTime
                            .month}-${widget.dateTime.day}",
                    style: TextStyle(fontSize: 19),))),
           TextButton(
              onPressed: onNextClick,
              child: Text("下一个"),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
          child: Row(
            children: [
              Text(
                "工号",
                textAlign: TextAlign.left,
              ),
              TextButton(
                  onPressed: addUserClick,
                  child: Text(
                    "添加",
                  ))
            ],
          ),
        ),
        Wrap(children: List<Widget>.generate(
          widget.userList.length,
              (int index) {
            User user = widget.userList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoiceChip(
                label: Text('# ${user.name}'),
                selected: widget.userName == user.name,
                onSelected: (bool selected) {
                  setState(() {
                    widget.userName = selected ? user.name : null;
                  });
                },
              ),
            );
          },
        ).toList(),),
        Row(children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                  labelText: "业绩:",
                  hintText: "请输入业绩(元)"
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")), //数字包括小数
              ],
              keyboardType: TextInputType.number,
              onChanged: (s) {

              },),
            flex: 1,
          ),
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                  labelText: "工资:",
                  hintText: "请输入工资(元)"
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")), //数字包括小数
              ],
              keyboardType: TextInputType.number,
              onChanged: (s) {
              },),
            flex: 1,
          ),
        ],
        ),
      ],
    );
  }
}
