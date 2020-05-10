import 'package:flutter/material.dart';
import 'package:gclone_flutter/helpers/file_selector.dart';

class ScheduleJobs extends StatefulWidget {
  @override
  ScheduleJobsState createState() {
    return ScheduleJobsState();
  }
}

class ScheduleJobsState extends State<ScheduleJobs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FileSelector(),
    );
  }
}
