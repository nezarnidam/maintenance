import 'package:flutter/material.dart';

import 'constants.dart';

class GetContainer {
  late final String str;
  late final Function() f;
  static Container getContainer({str: String, f: Function}) {
    return Container(
      padding: ktextfieldPadding,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        style: TextStyle(color: Colors.white),
        // autovalidate: true,
        onChanged: (value) => f(value),
        decoration: ktextfieldDecoration(str),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please provide $str';
          }
          return null;
        },
      ),
    );
  }
}
