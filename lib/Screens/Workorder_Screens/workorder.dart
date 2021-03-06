import 'package:flutter/material.dart';
import 'package:maintenance/Screens/Workorder_Screens/create_workorder.dart';

class WorkOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/createworkorder');
                },
                child: Container(
                  // height: 50.0,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.create),
                      title: Text(
                        'Create',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                      subtitle: Text('To create new work order'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1E33),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/updateworkorder');
                },
                child: Container(
                  // height: 50.0,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.update),
                      title: Text(
                        'Update',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                      subtitle: Text('To update work order'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1E33),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/viewworkorder');
                },
                child: Container(
                  // height: 50.0,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.folder_open_outlined),
                      title: Text(
                        'View',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                      subtitle: Text('To view work order'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1E33),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
