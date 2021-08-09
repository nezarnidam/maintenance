import 'package:http/http.dart' as http;
import 'dart:convert';

Map<String, String> mp = {};

class WorkorderDetailService {
  Future<int> getData(String workOrder_no) async {
    print("Inside WO Detail Service");
    var url = Uri.http('192.168.18.8:3000', '/mntWODetail');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'wo_num': workOrder_no,
      }),
    );

    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      mp = {
        "workorder": decodedData["workorder"],
        "notifNumber": decodedData["notifNumber"],
        "priority": decodedData["priority"],
        "priority_type": decodedData["priority_type"],
        "order_type": decodedData["order_type"],
        "start_date": decodedData["start_date"],
        "end_date": decodedData["end_date"],
        "planning_plant": decodedData["planning_plant"],
        "planner_group": decodedData["planner_group"],
        "func_location": decodedData["func_location"],
        "cost_center": decodedData["cost_center"],
        "currency": decodedData["currency"],
        "estimated_cost": decodedData["estimated_cost"],
        "equipment": decodedData["equipment"],
        "short_text": decodedData["short_text"],
        "system_status": decodedData["system_status"],
        "entered_by": decodedData["entered_by"],
        "duration": decodedData["duration"]
      };
    }
    print("Inside WO Detail Service");
    print(res.statusCode);
    return res.statusCode;
  }

  Map<String, String> getDetail() {
    return mp;
  }
}
