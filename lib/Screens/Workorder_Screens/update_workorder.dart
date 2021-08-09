import 'package:flutter/material.dart';
import 'package:maintenance/Screens/Workorder_Screens/create_workorder.dart';
import 'package:maintenance/Screens/Workorder_Screens/techcompleted_workorder.dart';

import 'Released_wo.dart';
import 'created_workorder.dart';

class UpdateWorkorder extends StatefulWidget {
  @override
  _UpdateWorkorderState createState() => _UpdateWorkorderState();
}

class _UpdateWorkorderState extends State<UpdateWorkorder> {
  int currentIndex = 0;

  List<Widget> Pages = [
    CreatedWorkorder('update'),
    ReleasedWorkorder('update'),
    TechCompletedWorkorder('update'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update workorder'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Created'),
          BottomNavigationBarItem(
              icon: Icon(Icons.new_releases_outlined), label: 'Released'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: 'Tech Completed')
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: Pages[currentIndex],
    );
  }
}
