import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gclone/routes/job_status.dart';
import 'package:gclone/routes/remotes.dart';
import 'package:gclone/routes/schedule_jobs.dart';

enum NavPages { Remotes, ScheduledJobs, JobStatus }

class NavigationProvider with ChangeNotifier {
  var currentNavigation = NavPages.Remotes;

  Widget get getNavigation {
    if (currentNavigation == NavPages.ScheduledJobs) {
      return ScheduleJobs();
    } else if (currentNavigation == NavPages.JobStatus) {
      return JobStatus();
    } else {
      return Remotes();
    }
  }

  void updateNavigation(var navigation) {
    currentNavigation = navigation;
    notifyListeners();
  }
}
