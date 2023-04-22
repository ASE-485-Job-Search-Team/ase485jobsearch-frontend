import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobsearchmobile/models/job_application.dart';
import 'package:jobsearchmobile/models/job_info.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/job_posting_item.dart';
import 'package:jobsearchmobile/screens/home/widgets/pie_chart.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/application_card.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/create_app_button.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';
import '../../constants/api.dart';
import '../../models/user.dart';
import '../../services/auth_api_service.dart';
import '../home/widgets/job_info_item.dart';

class MyJobPostings extends StatefulWidget {
  const MyJobPostings({Key? key}) : super(key: key);

  @override
  State<MyJobPostings> createState() => _MyJobPostingsState();
}

class _MyJobPostingsState extends State<MyJobPostings> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUserData();
  }

  Future<User> _loadUserData() async {
    String response = await APIService.getUserProfile();

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

  Future<List<JobPosting>> fetchJobPostingForBuilder(String id,
      {String query = ''}) async {
    final response =
        await http.get(Uri.parse('${Api.baseUrl}/companies/$id/jobs?$query'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((jobPosting) => JobPosting.fromJson(jobPosting))
          .toList();
    } else {
      throw Exception('Failed to load job postings');
    }
  }

  Map<DateTime, List<JobPosting>> mapByDate(List<JobPosting> jobPostings) {
    final Map<DateTime, List<JobPosting>> tmpJobPostingsByDate = {};
    jobPostings.sort((a, b) => b.datePosted.compareTo(a.datePosted));
    for (final jobPosting in jobPostings) {
      final date = jobPosting.datePosted;
      if (tmpJobPostingsByDate.containsKey(date)) {
        tmpJobPostingsByDate[date]?.add(jobPosting);
      } else {
        tmpJobPostingsByDate[date] = [jobPosting];
      }
    }
    return tmpJobPostingsByDate;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _userFuture,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data');
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
                            'Job Postings',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          FutureBuilder(
                              future: fetchJobPostingForBuilder(user!.id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final jobPostings =
                                      snapshot.data as List<JobPosting>;
                                  final jobPostingsByDate =
                                      mapByDate(jobPostings);
                                  return Column(
                                    children: jobPostingsByDate.entries
                                        .map((jobPosting) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat.yMMMMd()
                                                  .format(jobPosting.key)
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
                                              children: jobPosting.value
                                                  .map((jobPosting) {
                                                return JobPostingItem(
                                                  jobPosting: jobPosting,
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
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
        });
  }
}
