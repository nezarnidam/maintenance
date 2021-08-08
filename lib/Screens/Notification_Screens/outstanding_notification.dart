import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'detail_notification_screen.dart';
import 'detail_notification.dart';
import 'update_detail_notification.dart';
import '../../Services/Notification_Services/notification_getlist_service.dart';
import 'dart:convert';

class OutstandingNotification extends StatefulWidget {
  final String view;
  OutstandingNotification(this.view);

  @override
  _OutstandingNotificationState createState() =>
      _OutstandingNotificationState();
}

class _OutstandingNotificationState extends State<OutstandingNotification> {
  String prevView = '';
  List lst = [];
  bool loading = false;
  bool empty = false;

  final spinner = SpinKitDoubleBounce(
    color: Colors.blue.shade900,
    // color: Color(0xFF1D1E33),
    size: 50.0,
  );

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
        lst = notif.getOutstanding();
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
                      color: Color(0xFF1D1E33),
                      shadowColor: Color(0xFF1D1E33),
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
                                color: Color(0xFF0A0E21),
                              ),
                            ),
                            // child: Icon(
                            //   Icons.arrow_right_alt,
                            //   // color: Color(0xFF0A0E21),
                            // ),
                          ),
                          title: Text(getNotifno(index)),
                          subtitle: Text(getDescr(index)),
                          // trailing: Icon(
                          //   Icons.arrow_right_alt,
                          //   // color: Color(0xFF0A0E21),
                          // ),
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
