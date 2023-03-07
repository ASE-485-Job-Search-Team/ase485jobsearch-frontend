import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/job_info.dart';

class JobInfoItem extends StatelessWidget {
  final JobPosting jobPosting;

  const JobInfoItem({Key? key, required this.jobPosting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      padding: EdgeInsets.all(16),
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
                          width: 150,
                          child: Text(
                            jobPosting.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(jobPosting.company,
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.grey))
                      ])
                ],
              ),
              // IconButton(
              //   onPressed: () => {},
              //   icon: const Icon(Icons.bookmark_outline),
              // )
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
              // ActionChip(
              //   visualDensity: VisualDensity.compact,
              //   backgroundColor: Colors.blue,
              //   label: Text(
              //     jobPosting.jobType,
              //     // style: const TextStyle(
              //     //     color: Color.fromRGBO(0, 57, 124, 1), fontSize: 10.0),
              //   ),
              //   // backgroundColor: const Color.fromRGBO(239, 245, 253, 1),
              // ),
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
