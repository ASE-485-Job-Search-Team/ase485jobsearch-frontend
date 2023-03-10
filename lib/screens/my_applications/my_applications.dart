import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobsearchmobile/models/job_application.dart';
import 'package:jobsearchmobile/screens/home/widgets/pie_chart.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/application_card.dart';
import 'package:http/http.dart' as http;
import '../../constants/api.dart';

class MyApplications extends StatefulWidget {
  const MyApplications({Key? key}) : super(key: key);

  @override
  State<MyApplications> createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {
  Future<List<JobApplication>> fetchJobApplicationsForBuilder(
      {String query = ''}) async {
    final response =
        await http.get(Uri.parse('${Api.baseUrl}/applications?$query'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((jobApplication) => JobApplication.fromJson(jobApplication))
          .toList();
    } else {
      throw Exception('Failed to load job applications');
    }
  }

  Map<JobApplicationStatus, int> countByStatus(
      List<JobApplication> jobApplications) {
    Map<JobApplicationStatus, int> tmpStatusCount = {
      JobApplicationStatus.applied: 0,
      JobApplicationStatus.underReview: 0,
      JobApplicationStatus.offered: 0,
      JobApplicationStatus.rejected: 0,
      JobApplicationStatus.unknown: 0,
    };
    for (var application in jobApplications) {
      if (tmpStatusCount.containsKey(application.status)) {
        tmpStatusCount.update(application.status, (value) => value + 1);
      }
    }
    return tmpStatusCount;
  }

  Map<DateTime, List<JobApplication>> mapByDate(
      List<JobApplication> jobApplications) {
    final Map<DateTime, List<JobApplication>> tmpJobApplicationsByDate = {};
    jobApplications.sort((a, b) => b.dateApplied.compareTo(a.dateApplied));
    for (final jobApplication in jobApplications) {
      final date = jobApplication.dateApplied;
      if (tmpJobApplicationsByDate.containsKey(date)) {
        tmpJobApplicationsByDate[date]?.add(jobApplication);
      } else {
        tmpJobApplicationsByDate[date] = [jobApplication];
      }
    }
    return tmpJobApplicationsByDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            FutureBuilder(
                future: fetchJobApplicationsForBuilder(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final jobApplications =
                        snapshot.data as List<JobApplication>;
                    final jobApplicationsByStatus =
                        countByStatus(jobApplications);
                    return JobApplicationChart(
                      applied:
                          jobApplicationsByStatus[JobApplicationStatus.applied],
                      underReview: jobApplicationsByStatus[
                          JobApplicationStatus.underReview],
                      offered:
                          jobApplicationsByStatus[JobApplicationStatus.offered],
                      rejected: jobApplicationsByStatus[
                          JobApplicationStatus.rejected],
                      unknown:
                          jobApplicationsByStatus[JobApplicationStatus.unknown],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const Text(
              'My Applications',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16.0,
            ),
            FutureBuilder(
                future: fetchJobApplicationsForBuilder(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final jobApplications =
                        snapshot.data as List<JobApplication>;
                    final jobApplicationsByStatus =
                        countByStatus(jobApplications);
                    final jobApplicationsByDate = mapByDate(jobApplications);
                    return Column(
                      children:
                          jobApplicationsByDate.entries.map((jobApplication) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd()
                                  .format(jobApplication.key)
                                  .toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const Divider(),
                            Column(
                              children:
                                  jobApplication.value.map((jobApplication) {
                                return MyApplicationCard(
                                  jobApplication: jobApplication,
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
