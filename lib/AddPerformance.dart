import 'package:change/dao/FxDatabaseManager.dart';
import 'package:change/entity/Performance.dart';
import 'package:change/entity/User.dart';
import 'package:change/entity/UserBill.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 添加业绩工资记录
class AddPerformance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddPerformanceBodyPage();
  }
}

/// 添加营业记录界面
class AddPerformanceBodyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPerformanceBodyPageState();

  DateTime dateTime = DateTime.now();
  List<User> userList = List.empty(growable: true);
  List<UserBill> billList = List.empty(growable: true);
  int userNo = 0;
  int income = 0; // 业绩

  int salary = 0; // 工资


}

class _AddPerformanceBodyPageState extends State<AddPerformanceBodyPage> {
  @override
  void initState() {
    super.initState();
    findUserBillAndRefreshView();
    queryUsers();
  }

  void findUserBillAndRefreshView() {
    FxDatabaseManager.queryBillByDate(widget.dateTime).then((list) {
      setState(() {
        print("list: " + list.toString());
        widget.billList.clear();
        widget.billList.addAll(list);
      });
    });
  }

  List<DataRow> generateRows() {
    var list = widget.billList.expandIndexed((index, bill) =>
    {
      DataRow(cells: [
        DataCell(Text("#${bill.no}")),
        DataCell(Text("${bill.income}")),
        DataCell(Text("${bill.salary}")),
        DataCell(Text("删除", style: TextStyle(color: Colors.red),), onTap: () {
          deleteUserBill(bill);
        }),
      ])
    }).toList();

    if (widget.billList.length > 0) {
      var income = widget.billList.map((e) => e.income).reduce((a, b) => a + b);
      var salary = widget.billList.map((e) => e.salary).reduce((a, b) => a + b);
      list.add(DataRow(cells: [
        DataCell(Text("总计", style: TextStyle(color: Colors.blue),)),
        DataCell(Text("$income", style: TextStyle(color: Colors.blue),)),
        DataCell(Text("$salary", style: TextStyle(color: Colors.blue),)),
        DataCell(Text(""))
      ]));
    }

    return list;
  }

  deleteUserBill(UserBill bill) {
    print("delete bill");
    FxDatabaseManager.deleteUserBill(bill).then((value) =>
        findUserBillAndRefreshView());
  }

  void queryUsers() {
    FxDatabaseManager.getUsers().then((userList) {
      if (userList.isEmpty) return;
      setState(() {
        widget.userList.addAll(userList);
        if (widget.userNo == 0) {
          widget.userNo = userList[0].no;
        }
      });
    });
  }


  void onPreClick() {
    setState(() {
      widget.dateTime = DateUtils.addDaysToDate(widget.dateTime, -1);
      findUserBillAndRefreshView();
    });
  }

  void onNextClick() {
    setState(() {
      widget.dateTime = DateUtils.addDaysToDate(widget.dateTime, 1);
      findUserBillAndRefreshView();
    });
  }

  void savePerformance() {
    if (widget.income < 0 || widget.salary < 0) {
      Fluttertoast.showToast(
          msg: "请输入业绩和工资",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    User? user = widget.userList.firstWhereOrNull((element) =>
    element.no == widget.userNo);
    if (user == null) {
      Fluttertoast.showToast(
          msg: "请选择员工",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      FxDatabaseManager.savePerformance(Performance(user.uid!, widget.dateTime
          .millisecondsSinceEpoch, widget.income, widget.salary)).then((
          value) => findUserBillAndRefreshView());
    }
  }


  /// 添加用户点击
  void addUserClick() async {
    User? user = await showDialog(
        context: context,
        builder: (BuildContext context) {
          int userNo = 0
          return AlertDialog(
              title: Text("添加工号"),
              content: TextField(

                autofocus: true,
                onChanged: (String s) {
                  userNo = int.parse(s)
                },
                decoration: InputDecoration(
                    hintText: "请输入新增的工号",
                    prefixIcon: Icon(Icons.person_add,),
                    border: InputBorder.none),
                keyboardType: TextInputType.number,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text("取消",)),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, User(userNo));
                    },
                    child: Text("确定")),
              ]);
        });
    if (user != null) {
      FxDatabaseManager.insertUser(user).then((id) {
        user.uid = id;

        setState(() {
          widget.userNo = user.no;
          widget.userList.add(user);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
              shadowColor: Colors.white, foregroundColor: Colors.white)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("添加营业记录"),
          actions: [IconButton(onPressed: () {
            savePerformance();
          }, icon: Icon(Icons.check))
          ],
        ),
        body: Theme(data: ThemeData(primarySwatch: Colors.orange),
            child: SingleChildScrollView(
              child: Column(
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
                          label: Text('# ${user.no}'),
                          selected: widget.userNo == user.no,
                          onSelected: (bool selected) {
                            setState(() {
                              widget.userNo = selected ? user.no : 0;
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
                          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          //数字包括小数
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (s) {
                          widget.income = int.parse(s);
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
                          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          //数字包括小数
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (s) {
                          widget.salary = int.parse(s);
                        },),
                      flex: 1,
                    ),
                  ],
                  ),

                  DataTable(
                      sortAscending: true,
                      sortColumnIndex: 0,
                      columns: [
                        DataColumn(label: Text("工号")),
                        DataColumn(label: Text("业绩"), numeric: true),
                        DataColumn(label: Text("工资"), numeric: true),
                        DataColumn(label: Text("操作"))],
                      rows: generateRows()
                  )
                ],
              ),
            )),
      ),
    );
  }


}
