import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/widgets/job_info_item.dart';
import 'package:http/http.dart' as http;
import '../../../models/job_info.dart';
import '../../../services/job_posting_service.dart';

class HomeJobPostingList extends StatefulWidget {
  const HomeJobPostingList({Key? key}) : super(key: key);

  @override
  State<HomeJobPostingList> createState() => _HomeJobPostingListState();
}

class _HomeJobPostingListState extends State<HomeJobPostingList> {
  final jobPostingService = JobPostingService(httpClient: http.Client());
  // Future<List<JobPosting>> fetchJobPostingsForBuilder(http.Client client,
  //     {String query = ''}) async {
  //   final response =
  //       await client.get(Uri.parse('${Api.baseUrl}/jobPostings?$query'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = jsonDecode(response.body);
  //     return jsonData
  //         .map((jobPosting) => JobPosting.fromJson(jobPosting))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load job postings');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Recommended to you',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 136.0,
              child: FutureBuilder<List<JobPosting>>(
                future:
                    jobPostingService.fetchJobPostingsForBuilder(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return JobPostingListView(
                      snapshot: snapshot,
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              'New job postings',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 136.0,
              child: FutureBuilder<List<JobPosting>>(
                future: jobPostingService.fetchJobPostingsForBuilder(
                    http.Client(),
                    query: '_sort=datePosted&_order=desc'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return JobPostingListView(
                      snapshot: snapshot,
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              'Popular job postings',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 136.0,
              child: FutureBuilder<List<JobPosting>>(
                future:
                    jobPostingService.fetchJobPostingsForBuilder(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return JobPostingListView(
                      snapshot: snapshot,
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobPostingListView extends StatelessWidget {
  final dynamic snapshot;
  const JobPostingListView({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => JobInfoItem(
              jobPosting: snapshot.data![index],
            ),
        separatorBuilder: (_, index) => const SizedBox(
              width: 12.0,
            ),
        itemCount: snapshot.data!.length);
  }
}
