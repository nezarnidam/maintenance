import 'package:flutter/material.dart';

class info extends StatelessWidget {
  final String label;
  final String value;

  info(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: .2,
              fontSize: 20,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                letterSpacing: .5,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
