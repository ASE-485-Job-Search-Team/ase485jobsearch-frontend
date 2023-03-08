import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/widgets/search_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/tag_list.dart';

import 'app_bar.dart';
import 'job_posting_list.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeAppBar(),
            HomeSearchBar(),
            TagList(),
            HomeJobPostingList()
          ],
        ),
      ),
    );
  }
}
