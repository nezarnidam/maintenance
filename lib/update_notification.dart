import 'package:flutter/material.dart';

class UpdateNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update notification'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Outstanding',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Inprocess',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
