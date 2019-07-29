import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gclone/models/get_data.dart';
import 'package:gclone/routes/job_status.dart';
import 'package:gclone/routes/remotes.dart';
import 'package:gclone/routes/schedule_jobs.dart';

enum NavPages { Remotes, ScheduledJobs, JobStatus }

class NavigationProvider with ChangeNotifier {
  int currentNavigation = 1;

  NavigationProvider(this._getDataPlugin);
  final GetDataPlugin _getDataPlugin;

  Widget get getNavigation {
    if (currentNavigation == 1) {
      return ScheduleJobs();
    } else if (currentNavigation == 2) {
      return JobStatus();
    } else {
      return Remotes();
    }
  }

  void updateNavigation(int navigation) {
    currentNavigation = navigation;
    notifyListeners();
  }
}
