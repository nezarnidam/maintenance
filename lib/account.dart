import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          // margin: EdgeInsets.only(top: 10),
          height: 50.0,
          child: Center(
              child: ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Log out',
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  // fontSize: 30.0,
                  ),
            ),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF1D1E33),
          ),
        ),
      ),
    );
  }
}
