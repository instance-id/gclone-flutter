import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gclone_flutter/routes/job_status.dart';
import 'package:gclone_flutter/routes/remotes.dart';
import 'package:gclone_flutter/routes/schedule_jobs.dart';

enum NavPages { ScheduledJobs, Remotes, JobStatus, ProviderList }

class NavigationProvider with ChangeNotifier {
  int currentNavigation = 1;

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
