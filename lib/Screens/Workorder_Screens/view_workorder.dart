import 'package:flutter/material.dart';
import 'package:maintenance/Screens/Workorder_Screens/Released_wo.dart';
import 'package:maintenance/Screens/Workorder_Screens/created_workorder.dart';
import 'package:maintenance/Screens/Workorder_Screens/techcompleted_workorder.dart';

class ViewWorkorder extends StatefulWidget {
  @override
  _ViewWorkorderState createState() => _ViewWorkorderState();
}

class _ViewWorkorderState extends State<ViewWorkorder> {
  int currentIndex = 0;

  List<Widget> Pages = [
    CreatedWorkorder('getlist'),
    ReleasedWorkorder('getlist'),
    TechCompletedWorkorder('getlist'), //tech completed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View workorder'),
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
