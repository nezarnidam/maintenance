import 'package:flutter/material.dart';
import 'package:maintenance/Screens/Notification_Screens/inprocess_notification.dart';

import 'completed_notification.dart';
import 'outstanding_notification.dart';

class UpdateNotification extends StatefulWidget {
  @override
  _UpdateNotificationState createState() => _UpdateNotificationState();
}

class _UpdateNotificationState extends State<UpdateNotification> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      OutstandingNotification('update'),
      InprocessNotification('update'),
      CompletedNotification('update'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Update notification'),
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
            label: 'Inprocess',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
