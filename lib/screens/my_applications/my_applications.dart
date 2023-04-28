import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobsearchmobile/models/job_application.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/pie_chart.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/application_card.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/create_app_button.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';
import '../../constants/api.dart';
import '../../models/user.dart';
import '../../services/auth_api_service.dart';

class MyApplications extends StatefulWidget {
  final APIService apiService;
  const MyApplications({Key? key, required this.apiService}) : super(key: key);

  @override
  State<MyApplications> createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUserData();
  }

  Future<User> _loadUserData() async {
    String response = await widget.apiService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];
    User user;

    if (isAdmin) {
      user = User(
        id: model['data']['id'],
        name: model['data']['company'],
        email: model['data']['email'],
        isAdmin: true,
      );
    } else {
      user = User(
        id: model['data']['id'],
        name: model['data']['first'] + ' ' + model['data']['last'],
        email: model['data']['email'],
        resume: model['data']['resume'],
        isAdmin: false,
      );
    }

    return user;
  }

  Future<List<JobApplication>> fetchJobApplicationsForBuilder(String id,
      {String query = ''}) async {
    final response = await http.get(Uri.parse(
        '${Api.baseUrl}/users/$id/applications?$query')); //TODO: Replace with user id
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

  Map<String, List<JobApplication>> mapByDate(
      List<JobApplication> jobApplications) {
    final Map<String, List<JobApplication>> tmpJobApplicationsByDate = {};
    jobApplications.sort((a, b) => b.dateApplied.compareTo(a.dateApplied));
    for (final jobApplication in jobApplications) {
      final date = DateFormat.yMMMMd().format(jobApplication.dateApplied);
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
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          final user = snapshot.data;
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w600),
                        ),
                        // CreateAppButton(),
                        FutureBuilder(
                            future: fetchJobApplicationsForBuilder(user!.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final jobApplications =
                                    snapshot.data as List<JobApplication>;
                                final jobApplicationsByStatus =
                                    countByStatus(jobApplications);
                                return JobApplicationChart(
                                  applied: jobApplicationsByStatus[
                                      JobApplicationStatus.applied],
                                  underReview: jobApplicationsByStatus[
                                      JobApplicationStatus.underReview],
                                  offered: jobApplicationsByStatus[
                                      JobApplicationStatus.offered],
                                  rejected: jobApplicationsByStatus[
                                      JobApplicationStatus.rejected],
                                  unknown: jobApplicationsByStatus[
                                      JobApplicationStatus.unknown],
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        const Text(
                          'My Applications',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        FutureBuilder(
                            future: fetchJobApplicationsForBuilder(user!.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final jobApplications =
                                    snapshot.data as List<JobApplication>;
                                final jobApplicationsByDate =
                                    mapByDate(jobApplications);
                                return Column(
                                  children: jobApplicationsByDate.entries
                                      .map((jobApplication) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          jobApplication.key.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        const Divider(),
                                        Column(
                                          children: jobApplication.value
                                              .map((jobApplication) {
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
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
