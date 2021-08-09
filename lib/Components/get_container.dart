import 'package:flutter/material.dart';

import 'constants.dart';

class GetContainer {
  late final String str;
  late final Function() f;
  static Container getContainer(
      {@required str: String, @required f: Function, var init, bool? enabled}) {
    return Container(
      padding: ktextfieldPadding,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        style: TextStyle(color: Colors.white),
        // autovalidate: true,
        onChanged: (value) => f(value),
        decoration: ktextfieldDecoration(str),
        initialValue: init,
        enabled: enabled,
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
