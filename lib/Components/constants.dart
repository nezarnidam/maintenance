import 'package:flutter/material.dart';

const ktextfieldPadding =
    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0);

ButtonStyle ktextfieldButton = ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
  primary: Color(0xFF1D1E33),
  textStyle: TextStyle(
    color: Colors.white,
    fontSize: 18,
    letterSpacing: .2,
  ),
);

InputDecoration ktextfieldDecoration(String str) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    labelText: str,
    labelStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    hintText: str,
  );
}
