import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
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
                  Navigator.pushNamed(context, '/createnotification');
                },
                child: Container(
                  // height: 50.0,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.create),
                      title: Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('To create new notification'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1E33),
                    // color: Colors.deepPurple.shade700,
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
                  Navigator.pushNamed(context, '/updatenotification');
                },
                child: Container(
                  // height: 50.0,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.update),
                      title: Text(
                        'Update',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      subtitle: Text('To update notification'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1E33),
                    // color: Colors.deepPurple.shade700,
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
                  Navigator.pushNamed(context, '/viewnotification');
                },
                child: Container(
                  // height: 50.0,
                  child: Center(
                    child: ListTile(
                      subtitle: Text('To view notifcation'),
                      leading: Icon(
                        Icons.folder_open_outlined,
                        // size: 30.0,
                      ),
                      title: Text(
                        'View',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1E33),
                    // color: Colors.deepPurple.shade700,
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

// Icon(Icons.folder_open_outlined),
// Text(
//   'Notification Details',
//   style: TextStyle(
//       fontWeight: FontWeight.bold, fontSize: 30.0),
// ),
