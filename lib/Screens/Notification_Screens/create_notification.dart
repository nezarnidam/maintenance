import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../Services/Login_Services/login_service.dart';
import '../../Services/Notification_Services/notification_create_service.dart';

class CreateNotification extends StatefulWidget {
  const CreateNotification({Key? key}) : super(key: key);

  @override
  _CreateNotificationState createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  static bool loader = false;

  final spinner = SpinKitDoubleBounce(
    color: Colors.blue.shade900,
    size: 50.0,
  );

  String descr = '';
  String eqpmnt = '';
  String funcloc = '';
  String notiftype = '';
  String priority = '';
  String reportedby = '';
  DateTime malfuncDate = DateTime.now();
  TimeOfDay malfuncTime = TimeOfDay.now();
  DateTime reqstartDate = DateTime.now();
  DateTime reqendDate = DateTime.now();
  LoginService lg = LoginService();

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

  Future<void> _selectMalfuncTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: malfuncTime,
    );
    if (picked_s != null && picked_s != malfuncTime) {
      setState(() {
        malfuncTime = picked_s;
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      hintText: str,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create notification'),
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
                                style: TextStyle(color: Colors.white),
                                // autovalidate: true,
                                onChanged: (value) {
                                  descr = value;
                                  // print(value);
                                },
                                decoration: textfieldDecoration(
                                    'Notification Description'),
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
                                          return 'Please provide Priority';
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loader = true;
                                    });
                                    Map<String, String> mp = {
                                      "description": "$descr",
                                      "eqpmnt_id": "$eqpmnt",
                                      "func_loc": "$funcloc",
                                      "malfn_date": malfuncDate
                                          .toString()
                                          .substring(0, 10),
                                      "malfn_time": getTime(malfuncTime
                                          .format(context)
                                          .toString()),
                                      "notif_type": "$notiftype",
                                      "planner_grp": lg.getPlannerGrp(),
                                      "planning_plant": lg.getPlanningPlnt(),
                                      "priority": "$priority",
                                      "reported_by": "$reportedby",
                                      "reqend_date": reqendDate
                                          .toString()
                                          .substring(0, 10),
                                      "reqstart_date": reqstartDate
                                          .toString()
                                          .substring(0, 10),
                                    };
                                    NotifCreateService create =
                                        NotifCreateService();
                                    int ret = await create.getData(mp);
                                    setState(() {
                                      loader = false;
                                    });
                                    if (ret == 200) {
                                      print('notif no' + create.getNotifno());
                                      Fluttertoast.showToast(
                                          msg: "Notification Created with id " +
                                              create.getNotifno(),
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
                                              "Failed to create notification, Try again",
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
                                child: Text('Create Notification'),
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

// class CreateNotification extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Create notification'),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               flex: 8,
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           // autovalidate: true,
//                           onChanged: (value) {},
//                           decoration: const InputDecoration(
//                             // labelText: 'User id',
//                             filled: true,
//                             fillColor: Colors.white,
//                             // icon: Icon(
//                             //   Icons.person,
//                             //   color: Colors.white,
//                             // ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                               borderSide: BorderSide.none,
//                             ),
//                             hintText: 'Description',
//                             hintStyle: TextStyle(color: Colors.grey),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter Description';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           // autovalidate: true,
//                           onChanged: (value) {},
//                           decoration: const InputDecoration(
//                             // labelText: 'User id',
//                             filled: true,
//                             fillColor: Colors.white,
//                             // icon: Icon(
//                             //   Icons.person,
//                             //   color: Colors.white,
//                             // ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                               borderSide: BorderSide.none,
//                             ),
//                             hintText: 'Equipment id',
//                             hintStyle: TextStyle(color: Colors.grey),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter Equipment id';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           // autovalidate: true,
//                           onChanged: (value) {},
//                           decoration: const InputDecoration(
//                             // labelText: 'User id',
//                             filled: true,
//                             fillColor: Colors.white,
//                             // icon: Icon(
//                             //   Icons.person,
//                             //   color: Colors.white,
//                             // ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                               borderSide: BorderSide.none,
//                             ),
//                             hintText: 'Functional Location',
//                             hintStyle: TextStyle(color: Colors.grey),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter Functional Location';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           // autovalidate: true,
//                           onChanged: (value) {},
//                           decoration: const InputDecoration(
//                             // labelText: 'User id',
//                             filled: true,
//                             fillColor: Colors.white,
//                             // icon: Icon(
//                             //   Icons.person,
//                             //   color: Colors.white,
//                             // ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                               borderSide: BorderSide.none,
//                             ),
//                             hintText: 'Notification type',
//                             hintStyle: TextStyle(color: Colors.grey),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter Notification type';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.multiline,
//                           style: TextStyle(color: Colors.black),
//                           // autovalidate: true,
//                           onChanged: (value) {},
//                           decoration: const InputDecoration(
//                             // labelText: 'User id',
//                             filled: true,
//                             fillColor: Colors.white,
//                             // icon: Icon(
//                             //   Icons.person,
//                             //   color: Colors.white,
//                             // ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                               borderSide: BorderSide.none,
//                             ),
//                             hintText: 'Priority',
//                             hintStyle: TextStyle(color: Colors.grey),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter Priority';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Container(
//                         padding: ktextfieldPadding,
//                         child: Row(
//                           children: [
//                             Flexible(
//                               flex: 1,
//                               child: TextFormField(
//                                 decoration: textfieldDecoration('Malfunction Date'),
//                                 key: Key(malfuncDate.toString().substring(0, 10)),
//                                 initialValue: malfuncDate.toString().substring(0, 10),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 await _selectMalfuncDate(context);
//                                 setState(() {});
//                               },
//                               child: Text('Select date'),
//                               style: ktextfieldButton,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Expanded(
//             //   flex: 1,
//             //   child: Container(
//             //     color: Color(0xFF1D1E33),
//             //     child: Center(
//             //       child: Text(
//             //         'Create',
//             //         style: TextStyle(
//             //             // color: Color(0xFF1D1E33),
//             //             fontSize: 20.0,
//             //             fontWeight: FontWeight.bold),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ));
//   }
// }
