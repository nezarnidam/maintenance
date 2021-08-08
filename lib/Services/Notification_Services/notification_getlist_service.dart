import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Login_Services/login_service.dart';

List completed = [];
List inprocess = [];
List outstanding = [];
LoginService lg = LoginService();

class NotificationGetlistService {
  Future<int> getData() async {
    var url = Uri.http('192.168.18.8:3000', '/mntNotifGetlist');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'planning_plant': lg.getPlanningPlnt(),
        'planner_grp': lg.getPlannerGrp(),
      }),
    );

    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      completed = decodedData["completed"];
      inprocess = decodedData["inprocess"];
      outstanding = decodedData["outstanding"];
    }
    return res.statusCode;
  }

  List getCompleted() {
    return completed;
  }

  List getInprocess() {
    return inprocess;
  }

  List getOutstanding() {
    return outstanding;
  }
}
