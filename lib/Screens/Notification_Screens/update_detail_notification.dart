import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Services/Login_Services/login_service.dart';
import '../../Services/Notification_Services/notification_detail_service.dart';
import '../../Services/Notification_Services/notification_update_service.dart';
import 'package:intl/intl.dart';

class UpdateDetailNotification extends StatefulWidget {
  final String notif_no;
  UpdateDetailNotification(this.notif_no);
  @override
  _UpdateDetailNotificationState createState() =>
      _UpdateDetailNotificationState();
}

class _UpdateDetailNotificationState extends State<UpdateDetailNotification> {
  static bool loader = true;

  String notif = '';
  Map<String, String> data = {};
  String descr = '';
  String eqpmnt = '';
  String funcloc = '';
  String notiftype = '';
  String priority = '';
  String reportedby = '';
  DateTime malfuncDate = DateTime.now();
  TimeOfDay malfuncTime = TimeOfDay.now();
  DateTime reqstartDate = DateTime.now();
  TimeOfDay reqstartTime = TimeOfDay.now();
  DateTime reqendDate = DateTime.now();
  TimeOfDay reqendTime = TimeOfDay.now();
  LoginService lg = LoginService();

  final spinner = SpinKitDoubleBounce(
    color: Colors.blue.shade900,
    size: 50.0,
  );
  final _formKey = GlobalKey<FormState>();

  static const ktextfieldPadding =
      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0);

  ButtonStyle ktextfieldButton = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    primary: Color(0xFF1D1E33),
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      letterSpacing: .2,
    ),
  );

  void initState() {
    super.initState();
    notif = widget.notif_no;
    loadData();
  }

  void loadData() async {
    setState(() {
      loader = true;
    });

    NotificationDetailService detail = NotificationDetailService();
    await detail.getData(notif);
    setState(() {
      data = detail.getDetail();
      print(data);
      print(data["description"].toString());
      loader = false;
    });
    // print(data);
  }

  Future<void> _selectMalfuncDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: malfuncDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != malfuncDate) {
      setState(() {
        malfuncDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: reqstartDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != reqstartDate) {
      setState(() {
        reqstartDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: reqendDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != reqendDate) {
      setState(() {
        reqendDate = pickedDate;
      });
    }
  }

  Future<void> _selectMalfuncTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: malfuncTime,
    );
    if (picked_s != null && picked_s != malfuncTime) {
      setState(() {
        malfuncTime = picked_s;
        print(malfuncTime);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: reqstartTime,
    );
    if (picked_s != null && picked_s != reqstartTime) {
      setState(() {
        reqstartTime = picked_s;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: reqendTime,
    );
    if (picked_s != null && picked_s != reqendTime) {
      setState(() {
        reqendTime = picked_s;
      });
    }
  }

  String getTime(String time) {
    DateTime parsedTime = DateFormat.jm().parse(time);
    String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
    return formattedTime;
  }

  InputDecoration textfieldDecoration(String str) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      labelText: str,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
      hintText: str,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update notification'),
        ),
        body: loader == false
            ? Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    // flex: 8,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) {
                                  notif = value;
                                },
                                enabled: false,
                                decoration:
                                    textfieldDecoration('Notification No'),
                                initialValue: notif,
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                // autovalidate: true,
                                onChanged: (value) {
                                  descr = value;
                                  // print(value);
                                },
                                decoration: textfieldDecoration(
                                    'Notification Description'),
                                initialValue: data["description"].toString(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Notification Description';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                onChanged: (value) {
                                  eqpmnt = value;
                                  // print(value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Equipment id';
                                  }
                                  return null;
                                },
                                decoration: textfieldDecoration('Equipment ID'),
                                initialValue: data["eqpmnt_id"].toString(),
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                onChanged: (value) {
                                  funcloc = value;
                                  // print(value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Functional Location';
                                  }
                                  return null;
                                },
                                decoration:
                                    textfieldDecoration('Functional Location'),
                                initialValue: data["func_loc"].toString(),
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                // autovalidate: true,
                                onChanged: (value) {
                                  priority = value;
                                },
                                decoration: textfieldDecoration('Priority'),
                                initialValue: data["priority"].toString(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Priority';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      decoration: textfieldDecoration(
                                          'Malfunction Date'),
                                      key: Key(malfuncDate
                                          .toString()
                                          .substring(0, 10)),
                                      initialValue: malfuncDate
                                          .toString()
                                          .substring(0, 10),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please provide Malfunction date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _selectMalfuncDate(context);
                                      setState(() {});
                                    },
                                    child: Text('Select date'),
                                    style: ktextfieldButton,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      decoration: textfieldDecoration(
                                          'Malfunction Time'),
                                      key: Key(malfuncTime.toString()),
                                      initialValue: getTime(malfuncTime
                                          .format(context)
                                          .toString()),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please provide Malfunction time';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _selectMalfuncTime(context);
                                      setState(() {});
                                    },
                                    child: Text('Select time'),
                                    style: ktextfieldButton,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                onChanged: (value) {
                                  notiftype = value;
                                  // print(value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Notification type';
                                  }
                                  return null;
                                },
                                decoration:
                                    textfieldDecoration('Notification Type'),
                                initialValue: data["notif_type"].toString(),
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Planning plant';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  planningPlant = value;
                                },
                                decoration:
                                    textfieldDecoration('Planning Plant'),
                                initialValue: lg.getPlanningPlnt(),
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Planner group';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  plannerGrp = value;
                                },
                                decoration:
                                    textfieldDecoration('Planner Group'),
                                initialValue: lg.getPlannerGrp(),
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide Reported by';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  reportedby = value;
                                },
                                decoration: textfieldDecoration('Reported By'),
                                initialValue: data['reported_by'].toString(),
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please provide Start date';
                                        }
                                        return null;
                                      },
                                      decoration: textfieldDecoration(
                                          'Required Start Date'),
                                      key: Key(reqstartDate
                                          .toString()
                                          .substring(0, 10)),
                                      initialValue: reqstartDate
                                          .toString()
                                          .substring(0, 10),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _selectStartDate(context);
                                      setState(() {});
                                    },
                                    child: Text('Select date'),
                                    style: ktextfieldButton,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: ktextfieldPadding,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please provide End date';
                                        }
                                        return null;
                                      },
                                      decoration: textfieldDecoration(
                                          'Required End Date'),
                                      key: Key(reqendDate
                                          .toString()
                                          .substring(0, 10)),
                                      initialValue: reqendDate
                                          .toString()
                                          .substring(0, 10),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _selectEndDate(context);
                                      setState(() {});
                                    },
                                    child: Text('Select date'),
                                    style: ktextfieldButton,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    loader = true;
                                  });
                                  Map<String, String> mp = {
                                    "notif_no": "$notif",
                                    "description": "$descr",
                                    "eqpmnt_id": "$eqpmnt",
                                    "func_loc": "$funcloc",
                                    "malfn_date":
                                        malfuncDate.toString().substring(0, 10),
                                    "malfn_time": getTime(
                                        malfuncTime.format(context).toString()),
                                    "notif_type": "$notiftype",
                                    "planner_grp": lg.getPlannerGrp(),
                                    "planning_plant": lg.getPlanningPlnt(),
                                    "priority": "$priority",
                                    "reported_by": "$reportedby",
                                    "reqend_date":
                                        reqendDate.toString().substring(0, 10),
                                    "reqend_time": getTime(
                                        reqendTime.format(context).toString()),
                                    "reqstart_date": reqstartDate
                                        .toString()
                                        .substring(0, 10),
                                    "reqstart_time": getTime(reqstartTime
                                        .format(context)
                                        .toString()),
                                  };
                                  NotificationUpdateService create =
                                      NotificationUpdateService();
                                  int i = await create.getData(mp);
                                  setState(() {
                                    loader = true;
                                  });
                                  if (i == 200) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Notification Updated for " + notif,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFF0A0E21),
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Could not fulfil the request, try again! ",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFF0A0E21),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Text('Update Notification'),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.maxFinite, 50),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  primary: Color(0xFF1D1E33),
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: .2,
                                  ),
                                ),
                              ),
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     if (_formKey.currentState!.validate()) {
                            //       //         print('success');
                            //       //         // Navigator.push(
                            //       //         //   context,
                            //       //         //   MaterialPageRoute(builder: (context) => Home()),
                            //       //         // );
                            //     } else {
                            //       Fluttertoast.showToast(
                            //           msg: "Please fill all fields!",
                            //           toastLength: Toast.LENGTH_LONG,
                            //           gravity: ToastGravity.CENTER,
                            //           timeInSecForIosWeb: 1,
                            //           backgroundColor: Color(0xFF0A0E21),
                            //           textColor: Colors.red,
                            //           fontSize: 16.0);
                            //     }
                            //   },
                            //   child: Text('Create'),
                            //   style: ElevatedButton.styleFrom(
                            //     fixedSize: Size(double.maxFinite, 50),
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: 15.0, horizontal: 10.0),
                            //     primary: Color(0xFF1D1E33),
                            //     textStyle: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 18,
                            //       letterSpacing: .2,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       if (_formKey.currentState!.validate()) {
                  //         print('success');
                  //         // Navigator.push(
                  //         //   context,
                  //         //   MaterialPageRoute(builder: (context) => Home()),
                  //         // );
                  //       }
                  //     },
                  //     child: Container(
                  //       color: Color(0xFF1D1E33),
                  //       child: Center(
                  //         child: Text(
                  //           'Create',
                  //           style: TextStyle(
                  //               // color: Color(0xFF1D1E33),
                  //               fontSize: 20.0,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            : spinner);
  }
}
