import 'package:change/dao/FxDatabaseManager.dart';
import 'package:change/entity/User.dart';
import 'package:change/entity/UserBill.dart';
import 'package:change/extensio/TimeExtension.dart';
import 'package:dartx/dartx.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'AddPerformance.dart';

/// 业绩工资记录统计界面
class PerformanceStatisticPage extends StatefulWidget {
  DateTime dateTime = DateTime.now();
  List<UserBill> billList = List.empty(growable: true);
  List<User> userList = List.empty(growable: true);
  int userNo = 0;

  @override
  State<StatefulWidget> createState() {
    return PerformanceStatisticState();
  }
}

class PerformanceStatisticState extends State<PerformanceStatisticPage> {
  List<User> userList = [];
  User? currUser;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
              shadowColor: Colors.white, foregroundColor: Colors.white)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("营业额统计"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new AddPerformance())); // 跳转到添加业绩、工资记录界面
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  toExcel();
                },
                icon: Icon(Icons.share)),
          ],
        ),
        body: Theme(
          data: ThemeData(primarySwatch: Colors.orange),
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
                                  .month}",
                              style: TextStyle(fontSize: 19),
                            ))),
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
                Wrap(
                  children: List<Widget>.generate(
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
                              findUserBillAndRefreshView();
                            });
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
                DataTable(
                    sortAscending: true,
                    sortColumnIndex: 0,
                    columns: [
                      DataColumn(label: Text("日期")),
                      DataColumn(label: Text("业绩"), numeric: true),
                      DataColumn(label: Text("工资"), numeric: true),
                    ],
                    rows: generateRows())
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    findUserBillAndRefreshView();
    queryUsers();
    super.initState();
  }

  void onPreClick() {
    setState(() {
      widget.dateTime = DateUtils.addMonthsToMonthDate(widget.dateTime, -1);
      findUserBillAndRefreshView();
    });
  }

  void onNextClick() {
    setState(() {
      widget.dateTime = DateUtils.addMonthsToMonthDate(widget.dateTime, 1);
      findUserBillAndRefreshView();
    });
  }

  void findUserBillAndRefreshView() {
    FxDatabaseManager.queryBillByNoAndDate(widget.userNo, widget.dateTime)
        .then((list) {
      setState(() {
        print("list: " + list.toString());

        List<UserBill> emptyList = initEmptyBill();
        print("empty: " + emptyList.toString());
        copyDate2EmptyList(emptyList, list);

        widget.billList.clear();
        widget.billList.addAll(emptyList);
      });
    });
  }

  List<UserBill> initEmptyBill({isMax = false}) {
    List<UserBill> list = List.empty(growable: true);
    int time = widget.dateTime.millisecondsSinceEpoch;
    int minDate = time.getMinDateStampMonth();
    int endDate;
    if (isCurrMonth() && !isMax) {
      endDate = DateTime
          .now()
          .millisecondsSinceEpoch;
    } else {
      endDate = time.getMaxDateStampMonth();
    }

    var dateStamp = DateTime.fromMillisecondsSinceEpoch(minDate);
    while (dateStamp.millisecondsSinceEpoch >= minDate &&
        dateStamp.millisecondsSinceEpoch <= endDate) {
      list.add(UserBill.of(dateStamp.millisecondsSinceEpoch));
      dateStamp = dateStamp.add(Duration(days: 1));
    }
    return list;
  }

  List<UserBill> copyDate2EmptyList(List<UserBill> emptyBill,
      List<UserBill> dbBillList) {
    emptyBill.forEach((eBill) {
      var eDate = DateTime.fromMillisecondsSinceEpoch(eBill.dateStamp);
      dbBillList.forEach((dbBill) {
        var dbDate = DateTime.fromMillisecondsSinceEpoch(dbBill.dateStamp);
        if (isEqualDay(eDate, dbDate)) {
          eBill.copy(dbBill);
        }
      });
    });
    return emptyBill;
  }

  isCurrMonth() {
    return widget.dateTime.month == DateTime
        .now()
        .month;
  }

  isEqualDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void queryUsers() {
    FxDatabaseManager.getUsers().then((userList) {
      if (userList.isEmpty) return;
      setState(() {
        widget.userList.addAll(userList);
        if (widget.userNo == 0) {
          widget.userNo = userList[0].no;
          findUserBillAndRefreshView();
        }
      });
    });
  }

  List<DataRow> generateRows() {
    var list = widget.billList
        .expand((bill) =>
    {
      DataRow(cells: [
        DataCell(Text(
            "${DateTime
                .fromMillisecondsSinceEpoch(bill.dateStamp)
                .month}-${DateTime
                .fromMillisecondsSinceEpoch(bill.dateStamp)
                .day}")),
        DataCell(Text("${bill.income}")),
        DataCell(Text("${bill.salary}")),
      ])
    })
        .toList();

    if (widget.billList.length > 0) {
      var income = widget.billList.map((e) => e.income).reduce((a, b) => a + b);
      var salary = widget.billList.map((e) => e.salary).reduce((a, b) => a + b);
      list.add(DataRow(cells: [
        DataCell(Text(
          "总计",
          style: TextStyle(color: Colors.blue),
        )),
        DataCell(Text(
          "$income",
          style: TextStyle(color: Colors.blue),
        )),
        DataCell(Text(
          "$salary",
          style: TextStyle(color: Colors.blue),
        )),
      ]));
    }

    return list;
  }

  toExcel() {
 
    FxDatabaseManager.queryBillByDate(widget.dateTime).then((
        List<UserBill> billList) => {excelByBillList(billList)});
  }

  excelByBillList(List<UserBill> billList) {
    var uIdBillMap = copy2EmptyListGroupByUserId(billList);
    var performanceSumList = sumByDate(uIdBillMap.values.flatMap((element) => element).toList());
    var userList = billList.map((e) => User(e.no,uid: e.uid,name: e.name)).distinct();
    String shopName = "测试";
    var month = widget.dateTime.month;

    var excel = Excel.createExcel();

    Sheet sheetObject = excel["Sheet1"];
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single;

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    // printing cell-type
    print("CellType: " + cell.cellType.toString());
    
    sheetObject.insertRow(0);
    sheetObject.appendRow([

    ]);
    
    

  }

  sumByDate(List<UserBill> dbBillList) {
    var userBillMap =
    dbBillList.groupBy((UserBill e) => e.dateStamp.date2String(YYYY_MM_DD));
    var uIdBillMap = Map<String, Pair>();
    userBillMap.forEach((key, List<UserBill> value) {
      uIdBillMap[key] = Pair(value.sumBy((element) => element.income),
          value.sumBy((element) => element.salary));
    });
    return uIdBillMap;
  }

  Map<int, List<UserBill>> copy2EmptyListGroupByUserId(
      List<UserBill> dbBillList) {
    var userBillMap = dbBillList.groupBy((element) => element.uid);
    var uIdBillMap = Map<int, List<UserBill>>();
    userBillMap.forEach((key, value) {
      var list = value;
      uIdBillMap[key] = copyDate2EmptyList(initEmptyBill(isMax: true), list);
    });
    return uIdBillMap;
  }
}
