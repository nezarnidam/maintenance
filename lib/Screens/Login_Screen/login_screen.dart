import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Home_screen/home.dart';
import '../../Services/Login_Services/login_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String id;
  late String pass;

  bool loader = false;

  final spinner = SpinKitDoubleBounce(
    color: Colors.blue.shade900,
    size: 50.0,
  );

  Future<void> getData(String empid, String pass) async {
    int data;
    setState(() {
      loader = true;
    });
    LoginService loginReq = LoginService();
    data = await loginReq.getData(empid, pass);
    if (data == 200) {
      setState(() {
        loader = false;
      });
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else {
      setState(() {
        loader = false;
      });
      Fluttertoast.showToast(
          msg: "Username or Password is wrong!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          // timeInSecForIosWeb: 10,
          backgroundColor: Color(0xFF0A0E21),
          textColor: Colors.red,
          fontSize: 16.0);
      // print('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF0C1B2D),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: (loader == false)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white70,
                        ),
                      )),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              // autovalidate: true,
                              onChanged: (value) {
                                // print(value);
                                id = value;
                              },
                              decoration: const InputDecoration(
                                // labelText: 'User id',
                                filled: true,
                                fillColor: Colors.white,
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter user id',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter user id';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                pass = value;
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                // labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                icon: Icon(
                                  Icons.password,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              // autovalidate: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print(id);
                              getData(id, pass);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Home()),
                              // );
                            }
                          },
                          child: Container(
                            color: Color(0xFF1D1E33),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  // color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                )
              : spinner,
        ),
      ),
    );
  }
}
