import 'package:flutter/material.dart';
import 'detail_notification.dart';
import '../../Components/loading_page.dart';
import 'update_detail_notification.dart';
import '../../Services/Notification_Services/notification_detail_service.dart';
import '../../Services/Notification_Services/notification_getlist_service.dart';

import 'dart:convert';

class CompletedNotification extends StatefulWidget {
  final String view;
  CompletedNotification(this.view);

  @override
  _CompletedNotificationState createState() => _CompletedNotificationState();
}

class _CompletedNotificationState extends State<CompletedNotification> {
  String prevView = '';
  List lst = [];
  bool loading = false;
  bool empty = false;
  NotificationDetailService detail = NotificationDetailService();

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
        lst = notif.getCompleted();
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
    return loading
        ? LoadingPage()
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
                          onTap: () async {
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
                              await Navigator.push(
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
                                color: Colors.green,
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
