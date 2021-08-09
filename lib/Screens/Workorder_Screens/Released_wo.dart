import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maintenance/Components/loading_page.dart';
import 'package:maintenance/Screens/Workorder_Screens/detail_workorder.dart';
import 'package:maintenance/Screens/Workorder_Screens/update_detail_workorder.dart';
import 'package:maintenance/Services/Workorder_Services/workorder_getlist_service.dart';

class ReleasedWorkorder extends StatefulWidget {
  final view;
  ReleasedWorkorder(this.view);
  @override
  _ReleasedWorkorderState createState() => _ReleasedWorkorderState();
}

class _ReleasedWorkorderState extends State<ReleasedWorkorder> {
  String prevView = '';
  bool loading = false;

  bool empty = false;

  List list = [];

  initState() {
    super.initState();
    prevView = widget.view;
    loadData();
  }

  loadData() async {
    loading = true;
    WorkorderGetlistService wo = WorkorderGetlistService();
    int data = await wo.getData();
    print(data);

    if (data == 200) {
      setState(() {
        loading = false;
        list = wo.getReleased();
        if (list.length < 1) {
          empty = true;
        }
      });
    } else {
      setState(() {
        empty = true;
        loading = false;
      });
    }
  }

  String getDescr(int index) {
    var item = jsonEncode(list[index]);
    var decodedData = jsonDecode(item);
    return decodedData["WO_DESC"];
  }

  String getWorkorderno(int index) {
    var item = jsonEncode(list[index]);
    var decodedData = jsonDecode(item);
    return decodedData["WO_NO"];
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : empty
            ? Center(
                child: Text(
                'No data',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ))
            : ListView.builder(
                padding: EdgeInsets.all(15.0),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    child: Card(
                      elevation: 5,
                      color: Color(0xFF1D1E33),
                      shadowColor: Color(0xFF1D1E33),
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            if (prevView == 'getlist') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailWorkorder(
                                    getWorkorderno(index),
                                  ),
                                ),
                              );
                            }
                            if (prevView == 'update') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateDetailWorkorder(
                                    getWorkorderno(index),
                                  ),
                                ),
                              );
                            }
                          },
                          leading: SizedBox(
                            width: 20,
                            child: Center(
                              child: Icon(
                                Icons.circle,
                                color: Color(0xFF0A0E21),
                              ),
                            ),
                            // child: Icon(
                            //   Icons.arrow_right_alt,
                            //   // color: Color(0xFF0A0E21),
                            // ),
                          ),
                          title: Text(getWorkorderno(index)),
                          subtitle: Text(getDescr(index)),
                          // trailing: Icon(
                          //   Icons.arrow_right_alt,
                          //   // color: Color(0xFF0A0E21),
                          // ),
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
