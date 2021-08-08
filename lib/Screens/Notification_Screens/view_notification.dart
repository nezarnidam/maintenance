import 'package:flutter/material.dart';
import 'completed_notification.dart';
import 'inprocess_notification.dart';
import 'outstanding_notification.dart';

class ViewNotification extends StatefulWidget {
  @override
  _ViewNotificationState createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      OutstandingNotification('getlist'),
      InprocessNotification('getlist'),
      CompletedNotification('getlist'),
    ];
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // iconTheme: IconThemeData(
        //   color: Colors.black, //change your color here
        // ),
        title: Text(
          'View notification',
          // style: TextStyle(
          //   color: Color(0xff000000),
          // ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Outstanding',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge),
            label: 'In Process',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
        ],
      ),
      body: Center(
        child: pages[currentIndex],
      ),
    );
  }
}
