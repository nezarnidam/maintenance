import 'package:http/http.dart' as http;
import 'package:maintenance/Services/Login_Services/login_service.dart';
import 'dart:convert';

List created = [];
List released = [];
List techcompleted = [];
LoginService lg = LoginService();

class WorkorderGetlistService {
  Future<int> getData() async {
    // print('Inside WoGetList Service');
    var url = Uri.http('192.168.18.8:3000', '/mntWOGetlist');
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
      created = decodedData["created"];
      released = decodedData["released"];
      techcompleted = decodedData["techcompleted"];
    }
    // print('Inside WoGetList Service End');
    // print(res.statusCode);
    // print(created);
    return res.statusCode;
  }

  List getCreated() {
    return created;
  }

  List getReleased() {
    return released;
  }

  List getTechCompleted() {
    return techcompleted;
  }
}
