import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maintenance/Screens/Notification_Screens/detail_notification.dart';
import 'package:maintenance/Services/Notification_Services/notification_getlist_service.dart';
import 'package:maintenance/Screens/Notification_Screens/update_detail_notification.dart';

class InprocessNotification extends StatefulWidget {
  final String view;
  InprocessNotification(this.view);
  @override
  _InprocessNotificationState createState() => _InprocessNotificationState();
}

class _InprocessNotificationState extends State<InprocessNotification> {
  @override
  String prevView = '';
  List lst = [];
  bool loading = false;
  bool empty = false;

  void initState() {
    super.initState();
    prevView = widget.view;
    loadData();
  }

  void loadData() async {
    loading = true;

    NotificationGetlistService notif = NotificationGetlistService();
    int data = await notif.getData();

    if (data == 200) {
      setState(() {
        loading = false;
        lst = notif.getInprocess();
        if (lst.length < 1)
          empty = true;
        else
          empty = false;
      });
    } else {
      setState(() {
        empty = true;
        loading = false;
      });
    }
  }

  String getDescr(int index) {
    var item = jsonEncode(lst[index]);
    var decodedData = jsonDecode(item);
    return decodedData["NOTIF_DESC"];
  }

  String getNotifno(int index) {
    var item = jsonEncode(lst[index]);
    var decodedData = jsonDecode(item);
    return decodedData["NOTIF_NO"];
  }

  @override
  Widget build(BuildContext context) {
    final spinner = SpinKitDoubleBounce(
      color: Colors.blue.shade900,
      size: 50.0,
    );
    return loading
        ? spinner
        : empty
            ? Center(
                child: Text(
                'No Data!',
                // style: kheadingStyle,
              ))
            : ListView.builder(
                padding: EdgeInsets.all(15.0),
                itemCount: lst.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            if (prevView == 'getlist') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailNotification(
                                    getNotifno(index),
                                  ),
                                ),
                              );
                            }
                            if (prevView == 'update') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateDetailNotification(
                                    getNotifno(index),
                                  ),
                                ),
                              );
                            }
                          },
                          leading: SizedBox(
                            width: 20,
                            child: Center(
                              child: Icon(
                                Icons.circle,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          title: Text(getNotifno(index)),
                          subtitle: Text(getDescr(index)),
                          trailing: Icon(Icons.arrow_right_alt),
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
