import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/Components/get_container.dart';
import 'package:maintenance/Components/loading_page.dart';
import 'package:maintenance/Services/Workorder_Services/workorder_create_service.dart';

class CreateWorkorder extends StatefulWidget {
  @override
  _CreateWorkorderState createState() => _CreateWorkorderState();
}

class _CreateWorkorderState extends State<CreateWorkorder> {
  final _formKey = GlobalKey<FormState>();
  static const EdgeInsets ktextfieldPadding =
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0);

  String desc = '';

  String equipID = '';

  String matNO = '';

  String normalDuration = '';

  String notifNum = '';

  String notifType = '';

  String oprDesc = '';

  String orderType = '';

  String priority = '';

  String reqQuantity = '';

  String workActivity = '';

  bool loader = false;
  List<Widget> getList() {
    return [
      GetContainer.getContainer(
        str: 'Description',
        f: (value) {
          desc = value;
          print(desc);
          // print(value);
        },
      ),
      GetContainer.getContainer(
        str: 'Equipment id',
        f: (value) {
          equipID = value;
          print(equipID);
          // print(value);
        },
      ),
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
          print(normalDuration);
          // print(value);
        },
      ),
      GetContainer.getContainer(
        str: 'Notification Number',
        f: (value) {
          notifNum = value;
          print(notifNum);
          // print(value);
        },
      ),
      GetContainer.getContainer(
        str: 'Notification Type',
        f: (value) {
          notifType = value;
          print(notifType);
          // print(value);
        },
      ),
      GetContainer.getContainer(
        str: 'Opr Description',
        f: (value) {
          oprDesc = value;
          print(oprDesc);
          // print(value);
        },
      ),
      GetContainer.getContainer(
        str: 'Order Type',
        f: (value) {
          orderType = value;
          print(orderType);
          // print(value);
        },
      ),
      GetContainer.getContainer(
        str: 'Priority',
        f: (value) {
          priority = value;
          print(priority);
          // print(value);
        },
      ),
      // GetContainer.getContainer(
      //   str: 'Requirement quantity',
      //   f: (value) {
      //     reqQuantity = value;
      //     print(reqQuantity);
      //     // print(value);
      //   },
      // ),
      GetContainer.getContainer(
        str: 'Work Activity',
        f: (value) {
          workActivity = value;
          print(workActivity);
          // print(value);
        },
      ),
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                loader = true;
              });
              Map<String, String> mp = {
                'desc': desc,
                'equipID': equipID,
                'matNO': matNO,
                'normalDuration': normalDuration,
                'notifNum': notifNum,
                'notifType': notifType,
                'oprDesc': oprDesc,
                'orderType': orderType,
                'priority': priority,
                'reqQuantity': reqQuantity,
                'workActivity': workActivity,
              };
              WorkorderCreateService create = WorkorderCreateService();
              int ret = await create.getData(mp);
              setState(() {
                loader = false;
              });
              if (ret == 200) {
                print('workorder no' + create.getWorkorderno());
                Fluttertoast.showToast(
                    msg: "workorder Created with id " + create.getWorkorderno(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xFF0A0E21),
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(
                    msg: "Failed to create notification," +
                        create.getErrorMessage(),
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
          child: Text('Create Work order'),
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
        title: Text('Create workorder'),
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

  InputDecoration textfieldDecoration(String str) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      labelText: str,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      hintText: str,
    );
  }

  // Container getContainer({str: String, f: Function}) {
  //   return Container(
  //     padding: ktextfieldPadding,
  //     child: TextFormField(
  //       keyboardType: TextInputType.multiline,
  //       style: TextStyle(color: Colors.white),
  //       // autovalidate: true,
  //       onChanged: f(),
  //       decoration: textfieldDecoration(str),
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return 'Please provide $str';
  //         }
  //         return null;
  //       },
  //     ),
  //   );
  // }
}
