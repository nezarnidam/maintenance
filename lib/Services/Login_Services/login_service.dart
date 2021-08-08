import 'package:http/http.dart' as http;
import 'dart:convert';

late String planningPlant;
late String plannerGrp;

class LoginService {
  Future<int> getData(String empId, String pass) async {
    var url = Uri.http('192.168.18.8:3000', '/mntLogin');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'employee_id': empId,
        'pass': pass,
      }),
    );
    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      planningPlant = decodedData["PLANNING_PLANT"];
      plannerGrp = decodedData["PLANNER_GROUP"];
      print(plannerGrp);
      print(planningPlant);
    }
    // if (decodedData["RETURN"] == 'S')
    return res.statusCode;
    // else
    //   return 400;
  }

  String getPlannerGrp() {
    return plannerGrp;
  }

  String getPlanningPlnt() {
    return planningPlant;
  }
}
