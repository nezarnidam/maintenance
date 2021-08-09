import 'package:flutter/material.dart';
import 'package:maintenance/Components/info.dart';
import 'package:maintenance/Components/loading_page.dart';
import 'package:maintenance/Services/Workorder_Services/workorder_detail_service.dart';

class DetailWorkorder extends StatefulWidget {
  final String wo_no;
  DetailWorkorder(this.wo_no);
  @override
  _DetailWorkorderState createState() => _DetailWorkorderState();
}

class _DetailWorkorderState extends State<DetailWorkorder> {
  bool load = true;
  String wo = '';
  Map<String, String> data = {};

  void initState() {
    super.initState();
    wo = widget.wo_no;
    loadData();
  }

  void loadData() async {
    WorkorderDetailService detail = WorkorderDetailService();
    await detail.getData(wo);
    setState(() {
      data = detail.getDetail();
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed notification',
        ),
      ),
      body: load
          ? LoadingPage()
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    info('Workorder No:', '$wo'),
                    info('Description:', data["short_text"].toString()),
                    info('Priority:', data["priority"].toString()),
                    info('Equipment No:', data["equipment"].toString()),
                    info('Planning Plant:', data["planning_plant"].toString()),
                    info('Planner Group:', data["planner_group"].toString()),
                    info('Functional location:',
                        data["func_location"].toString()),
                    info('Estimated Cost:', data["estimated_cost"].toString()),
                    info('Duration:', data["duration"].toString()),
                    info('Entered By:', data["entered_by"].toString()),
                  ],
                );
              },
            ),
    );
  }
}
