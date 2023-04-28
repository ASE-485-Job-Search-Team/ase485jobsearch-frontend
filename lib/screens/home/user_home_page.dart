import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/search_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/tag_list.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

import '../../models/user.dart';
import 'widgets/app_bar.dart';
import 'widgets/job_posting_list.dart';

class UserHomePage extends StatelessWidget {
  final APIService apiService;
  final User user;
  const UserHomePage({Key? key, required this.user, required this.apiService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(
              user: user,
            ),
            // HomeSearchBar(),
            // TagList(),
            SizedBox(height: 16.0),
            HomeJobPostingList(apiService: apiService,),
          ],
        ),
      ),
    );
  }
}
