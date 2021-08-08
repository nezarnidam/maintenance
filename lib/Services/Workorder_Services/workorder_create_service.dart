import 'package:http/http.dart' as http;
import 'dart:convert';

late String workOrder_no;

class WorkorderCreateService {
  Future<int> getData(Map<String, String> mp) async {
    var url = Uri.http('192.168.18.8:3000', '/mntWOCreate');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'desc': mp['desc'].toString(),
        'equipID': mp['equipID'].toString(),
        'matNO': mp['matNO'].toString(),
        'normalDuration': mp['normalDuration'].toString(),
        'notifNum': mp['notifNum'].toString(),
        'notifType': mp['notifType'].toString(),
        'oprDesc': mp['oprDesc'].toString(),
        'orderType': mp['orderType'].toString(),
        'priority': mp['priority'].toString(),
        'reqQuantity': mp['reqQuantity'].toString(),
        'workActivity': mp['workActivity'].toString(),
      }),
    );

    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(decodedData);
      workOrder_no = decodedData["workOrder_no"];
    }
    return res.statusCode;
  }

  String getWorkorderno() {
    return workOrder_no;
  }
}
