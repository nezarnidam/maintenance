import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/Components/get_container.dart';
import 'package:maintenance/Components/loading_page.dart';
import 'package:maintenance/Services/Workorder_Services/workorder_create_service.dart';
import 'package:maintenance/Services/Workorder_Services/workorder_detail_service.dart';
import 'package:maintenance/Services/Workorder_Services/workorder_update_service.dart';

class UpdateDetailWorkorder extends StatefulWidget {
  final workorderNo;
  UpdateDetailWorkorder(this.workorderNo);
  @override
  _UpdateDetailWorkorderState createState() => _UpdateDetailWorkorderState();
}

class _UpdateDetailWorkorderState extends State<UpdateDetailWorkorder> {
  final _formKey = GlobalKey<FormState>();

  String wo = '';
  Map<String, String> data = {};
  String desc = '';
  String workorderNo = '';
  String priority = '';
  String equipID = '';
  String normalDuration = '';
  String notifNum = '';
  String notifType = '';
  String orderType = '';
  String oprDesc = '';

  bool loader = false;

  void initState() {
    super.initState();
    wo = widget.workorderNo;
    loadData();
  }

  void loadData() async {
    setState(() {
      loader = true;
    });

    WorkorderDetailService detail = WorkorderDetailService();
    await detail.getData(wo);
    setState(() {
      data = detail.getDetail();
      print(data);
      print(data["description"].toString());
      print('notification number --- ' + data["notifNumber"].toString());
      loader = false;
    });
    workorderNo = data["workorder"].toString();
    desc = data["short_text"].toString();
    equipID = data["equipment"].toString();
    notifNum = data["notifNumber"].toString();
    notifType = data["priority_type"].toString();
    orderType = data["order_type"].toString();
    priority = data["priority"].toString();
    normalDuration = data["duration"].toString();
    // print(data);
  }

  List<Widget> getList() {
    return [
      GetContainer.getContainer(
          str: 'Workorder Number',
          f: (value) {
            workorderNo = value;
          },
          init: data["workorder"].toString(),
          enabled: false),
      // GetContainer.getContainer(
      //     str: 'Description',
      //     f: (value) {
      //       desc = value;
      //       // print(desc);
      //       // print(value);
      //     },
      //     init: data["short_text"].toString()),
      GetContainer.getContainer(
          str: 'Equipment id',
          f: (value) {
            equipID = value;
            // print(equipID);
            // print(value);
          },
          init: data["equipment"].toString()),
      // GetContainer.getContainer(
      //   str: 'Material Number',
      //   f: (value) {
      //     matNO = value;
      //     print(matNO);
      //     // print(value);
      //   },
      // ),
      GetContainer.getContainer(
          str: 'Normal Duration',
          f: (value) {
            normalDuration = value;
            // print(normalDuration);
            // print(value);
          },
          init: data["duration"].toString()),
      // GetContainer.getContainer(
      //     str: 'Notification Number',
      //     f: (value) {
      //       notifNum = value;
      //       // print(notifNum);
      //       // print(value);
      //     },
      //     enabled: false,
      //     init: data["notifNumber"].toString()),

      GetContainer.getContainer(
          str: 'Notification Type',
          f: (value) {
            notifType = value;
            // print(notifType);
            // print(value);
          },
          init: data["priority_type"].toString()),
      GetContainer.getContainer(
          str: 'Opr Description',
          f: (value) {
            desc = value;
            // print(oprDesc);
            // print(value);
          },
          init: desc = data["short_text"].toString()),
      GetContainer.getContainer(
          str: 'Order Type',
          f: (value) {
            orderType = value;
            // print(orderType);
            // print(value);
          },
          init: data["order_type"].toString()),
      GetContainer.getContainer(
          str: 'Priority',
          f: (value) {
            priority = value;
            // print(priority);
            // print(value);
          },
          init: data["priority"].toString()),
      // GetContainer.getContainer(
      //   str: 'Requirement quantity',
      //   f: (value) {
      //     reqQuantity = value;
      //     print(reqQuantity);
      //     // print(value);
      //   },
      // ),

      Padding(
        padding: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                loader = true;
              });
              Map<String, String> mp = {
                "description": desc,
                'duration': normalDuration,
                "equipID": equipID,
                "notifNum": notifNum,
                "oprDesc": oprDesc,
                "workOrderNum": workorderNo,
                "orderType": orderType,
                "priority": priority,
                "notiftype": notifType,
              };
              WorkorderUpdateService create = WorkorderUpdateService();
              int ret = await create.getData(mp);
              setState(() {
                loader = false;
              });
              if (ret == 200) {
                print('workorder updated');
                Fluttertoast.showToast(
                    msg: 'workorder updated',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xFF0A0E21),
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(
                    msg: "Failed to update workorder,",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xFF0A0E21),
                    textColor: Colors.red,
                    fontSize: 16.0);
              }
            } else {
              Fluttertoast.showToast(
                  msg: "Please fill all fields!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xFF0A0E21),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: Text('Update Work order'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 50),
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            primary: Color(0xFF1D1E33),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: .2,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update details workorder'),
      ),
      body: loader
          ? LoadingPage()
          : Form(
              key: _formKey,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getList(),
                    );
                  }),
            ),
    );
  }
}
