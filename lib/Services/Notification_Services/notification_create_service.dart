import 'package:http/http.dart' as http;
import 'dart:convert';

late String notif_no;

class NotifCreateService {
  Future<int> getData(Map<String, String> mp) async {
    var url = Uri.http('192.168.18.8:3000', '/mntNotifCreate');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'description': mp['description'].toString(),
        "eqpmnt_id": mp['eqpmnt_id'].toString(),
        "func_loc": mp['func_loc'].toString(),
        "malfn_date": mp['malfn_date'].toString(),
        "malfn_time": mp['malfn_time'].toString(),
        "notif_type": mp['notif_type'].toString(),
        "planner_grp": mp['planner_grp'].toString(),
        "planning_plant": mp['planning_plant'].toString(),
        "priority": mp['priority'].toString(),
        "reported_by": mp['reported_by'].toString(),
        "reqend_date": mp['reqend_date'].toString(),
        "reqstart_date": mp['reqstart_date'].toString(),
      }),
    );

    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(decodedData);
      notif_no = decodedData["notif_no"];
    }
    return res.statusCode;
  }

  String getNotifno() {
    return notif_no;
  }
}
