import 'package:http/http.dart' as http;
import 'dart:convert';

Map<String, String> mp = {};
String description = '';
String eqpmnt_id = '';
String func_loc = '';
String priority = '';
String reportedby = '';

class NotificationDetailService {
  Future<int> getData(String notif_no) async {
    var url = Uri.http('192.168.18.8:3000', '/mntNotifDetail');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'notif_no': notif_no,
      }),
    );

    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      mp = {
        "description": decodedData["description"],
        "eqpmnt_id": decodedData["eqpmnt_id"],
        "func_loc": decodedData["func_loc"],
        "malfn_date": decodedData["malfn_date"],
        "malfn_time": decodedData["malfn_time"],
        "notif_type": decodedData["notif_type"],
        "planner_grp": decodedData["planner_grp"],
        "planning_plant": decodedData["planning_plant"],
        "priority": decodedData["priority"],
        "reported_by": decodedData["reported_by"],
        "reqend_date": decodedData["reqend_date"],
        "reqstart_date": decodedData["reqstart_date"],
        "created_by": decodedData["created_by"]
      };

      description = decodedData["description"];
      eqpmnt_id = decodedData["eqpmnt_id"];
      func_loc = decodedData["func_loc"];
      priority = decodedData["priority"];
      reportedby = decodedData["reported_by"];
    }
    return res.statusCode;
  }

  Map<String, String> getDetail() {
    return mp;
  }

  String getDesc() {
    return description;
  }

  String getEqpmntID() {
    return eqpmnt_id;
  }

  String getFuncLoc() {
    return func_loc;
  }

  String getPriority() {
    return priority;
  }

  String getReportedBy() {
    return reportedby;
  }
}
