import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Services/Notification_Services/notification_detail_service.dart';
import '../../Components/info.dart';

class DetailNotification extends StatefulWidget {
  final String notif_no;
  DetailNotification(this.notif_no);

  @override
  _DetailNotificationState createState() => _DetailNotificationState();
}

class _DetailNotificationState extends State<DetailNotification> {
  bool load = true;
  String notif = '';
  Map<String, String> data = {};

  void initState() {
    super.initState();
    notif = widget.notif_no;
    loadData();
  }

  void loadData() async {
    NotificationDetailService detail = NotificationDetailService();
    await detail.getData(notif);
    setState(() {
      data = detail.getDetail();
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final spinner = SpinKitDoubleBounce(
      color: Colors.blue.shade900,
      size: 50.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed notification',
        ),
      ),
      body: load
          ? spinner
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: 90,
                    //   color: Colors.black87,
                    //   padding: EdgeInsets.symmetric(vertical: 25),
                    //   child: Center(
                    //     child: Text(
                    //       'NOTIFICATION',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         letterSpacing: .5,
                    //         fontSize: 30,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    info('Notification No:', '$notif'),
                    info('Priority:', data["priority"].toString()),
                    info('Description:', data["description"].toString()),
                    info('Equipment No:', data["eqpmnt_id"].toString()),
                    info('Functional Location:', data["func_loc"].toString()),
                    info('Malfunction Date:', data["malfn_date"].toString()),
                    info('Malfunction Time:', data["malfn_time"].toString()),
                    info('Planning Plant:', data["planning_plant"].toString()),
                    info('Planner Group:', data["planner_grp"].toString()),
                    info('Start Date:', data["reqstart_date"].toString()),
                    info('End Date:', data["reqend_date"].toString()),
                    info('Created By:', data["created_by"].toString()),
                    info('Reported By:', data["reported_by"].toString()),
                  ],
                );
              },
            ),
    );
  }
}
