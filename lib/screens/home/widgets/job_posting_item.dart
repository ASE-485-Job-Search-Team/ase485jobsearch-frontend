import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/job_info.dart';
import 'package:jobsearchmobile/screens/home/widgets/job_detail.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/applicants_list.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

class JobPostingItem extends StatelessWidget {
  final APIService apiService;
  final JobPosting jobPosting;

  const JobPostingItem({Key? key, required this.jobPosting, required this.apiService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Image.network(jobPosting.companyLogo),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            jobPosting.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(jobPosting.company,
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.grey))
                      ]),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.0,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    jobPosting.location,
                    style:
                        TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                  )
                ],
              ),
              Row(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplicantsList(
                                jobPosting: jobPosting,
                              )),
                    );
                  },
                  child: Chip(
                    label: Text(
                      'Applicants',
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey.shade700),
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) => JobDetail(
                        jobPosting: jobPosting,
                        displayApplyButton: false,
                        apiService: apiService,
                      ),
                    );
                  },
                  child: Chip(
                    label: Text(
                      'Details',
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey.shade700),
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.grey.shade100,
                  ),
                )
              ])
            ],
          ),
          // Row(
          //   children: [
          //     ActionChip(
          //         visualDensity: VisualDensity.compact,
          //         label: Text(
          //           'See more',
          //           style: TextStyle(
          //               fontSize: 12.0, fontWeight: FontWeight.normal),
          //         )),
          //     ActionChip(
          //         visualDensity: VisualDensity.compact,
          //         label: Text(
          //           'Save',
          //           style: TextStyle(
          //               fontSize: 12.0, fontWeight: FontWeight.normal),
          //         ))
          //   ],
          // )
        ],
      ),
    );
  }
}
