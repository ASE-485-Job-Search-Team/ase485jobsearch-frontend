import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/job_application.dart';

class MyApplicationCard extends StatelessWidget {
  final JobApplication jobApplication;
  const MyApplicationCard({Key? key, required this.jobApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.withOpacity(0.1)),
            child: Image.network(jobApplication.jobPosting.companyLogo),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  jobApplication.jobPosting.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(jobApplication.jobPosting.company,
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Chip(
            backgroundColor: jobApplication.status.backgroundColor,
            visualDensity: VisualDensity.compact,
            label: Text(
              jobApplication.status.name,
              style:
                  TextStyle(fontSize: 12.0, color: jobApplication.status.color),
            ),
          ),
        ],
      ),
    );
  }
}
