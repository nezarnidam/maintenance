import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkorderUpdateService {
  Future<int> getData(Map<String, String> mp) async {
    print('map from update details:--' + mp.toString());
    var url = Uri.http('192.168.18.8:3000', '/mntWOUpdate');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "description": mp['description'].toString(),
        'duration': mp['duration'].toString(),
        "equipID": mp['equipID'].toString(),
        "notifNum": mp['notifNum'].toString(),
        "oprDesc": mp['oprDesc'].toString(),
        "workOrderNum": mp['workOrderNum'].toString(),
        "orderType": mp['orderType'].toString(),
        "priority": mp['priority'].toString(),
        "notiftype": mp['notiftype'].toString(),
      }),
    );

    var decodedData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(decodedData);
    }
    return res.statusCode;
  }
}
