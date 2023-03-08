import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobsearchmobile/models/job_application.dart';
import 'package:jobsearchmobile/screens/home/widgets/pie_chart.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/application_card.dart';

import '../../models/job_info.dart';

class MyApplications extends StatefulWidget {
  const MyApplications({Key? key}) : super(key: key);

  @override
  State<MyApplications> createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {
  List<JobApplication> jobApplications = [
    JobApplication(
      id: 1,
      dateApplied: DateTime(2023, 3, 8),
      status: JobApplicationStatus.applied,
      jobSeekerId: 1,
      jobPostingId: 1,
      jobPosting: JobPosting(
        title: "Software Engineer",
        company: "Google LLC",
        location: "New York, NY",
        jobType: "Full-time",
        description:
            "We're looking for a talented software engineer to join our team and help us build amazing products.",
        qualifications: [
          "Bachelor's degree in Computer Science or related field",
          "3+ years of experience in software development",
          "Proficiency in Java, Python, or Ruby",
          "Strong problem-solving skills",
          "Excellent communication skills",
        ],
        responsibilities: [
          "Develop and maintain high-quality software using best practices",
          "Collaborate with cross-functional teams to design and implement new features",
          "Write clean, efficient, and well-documented code",
          "Participate in code reviews and contribute to continuous improvement of our development processes",
          "Stay up-to-date with emerging trends and technologies in software development",
        ],
        datePosted: DateTime(2022, 12, 1),
        dateClosing: DateTime(2023, 1, 31),
        companyLogo:
            "https://companiesmarketcap.com/img/company-logos/64/GOOG.webp",
        salaryRange: '\$150,000 - \$180,000',
      ),
    ),
    JobApplication(
      id: 2,
      dateApplied: DateTime(2023, 3, 8),
      status: JobApplicationStatus.underReview,
      jobSeekerId: 1,
      jobPostingId: 2,
      jobPosting: JobPosting(
        title: "Marketing Manager",
        company: "Netflix",
        location: "Los Angeles, CA",
        jobType: "Full-time",
        description:
            "We're seeking an experienced marketing manager to help us develop and execute effective marketing strategies.",
        qualifications: [
          "Bachelor's degree in Marketing or related field",
          "5+ years of experience in marketing or related field",
          "Excellent communication and interpersonal skills",
          "Proven track record of developing and executing successful marketing campaigns",
          "Strong analytical skills and ability to interpret data to inform decision-making",
        ],
        responsibilities: [
          "Develop and execute comprehensive marketing strategies that align with business goals",
          "Collaborate with cross-functional teams to create compelling marketing materials",
          "Manage marketing campaigns across multiple channels, including email, social media, and paid advertising",
          "Track and analyze key marketing metrics to measure effectiveness of campaigns and make data-driven decisions",
          "Stay up-to-date with emerging trends and technologies in marketing",
        ],
        datePosted: DateTime(2022, 11, 15),
        dateClosing: DateTime(2023, 2, 28),
        companyLogo:
            "https://companiesmarketcap.com/img/company-logos/64/NFLX.webp",
        salaryRange: '\$150,000 - \$180,000',
      ),
    ),
    JobApplication(
      id: 3,
      dateApplied: DateTime(2023, 1, 5),
      status: JobApplicationStatus.offered,
      jobSeekerId: 1,
      jobPostingId: 3,
      jobPosting: JobPosting(
        title: "Product Designer",
        company: "Airbnb Inc",
        location: "San Francisco, CA",
        jobType: "Full-time",
        description:
            "We're seeking a talented product designer to help us create beautiful, user-friendly products that solve real-world problems.",
        qualifications: [
          "Bachelor's or Master's degree in Design or related field",
          "3+ years of experience in product design",
          "Proficiency in Sketch, Figma, or Adobe Creative Suite",
          "Strong portfolio showcasing design work for web or mobile applications",
          "Excellent communication and collaboration skills",
        ],
        responsibilities: [
          "Collaborate with cross-functional teams to design and prototype new products and features",
          "Create wireframes, mockups, and high-fidelity designs using design tools",
          "Iterate on designs based on feedback from users and stakeholders",
          "Maintain design systems and ensure consistency across all products and platforms",
          "Stay up-to-date with emerging trends and technologies in product design",
        ],
        datePosted: DateTime(2022, 10, 1),
        dateClosing: DateTime(2023, 3, 10),
        companyLogo:
            "https://companiesmarketcap.com/img/company-logos/64/ABNB.webp",
        salaryRange: '\$150,000 - \$180,000',
      ),
    ),
    JobApplication(
      id: 1,
      dateApplied: DateTime(2023, 3, 1),
      status: JobApplicationStatus.offered,
      jobSeekerId: 1,
      jobPostingId: 1,
      jobPosting: JobPosting(
        title: "Software Development Engineer",
        company: "Amazon",
        location: "Seattle, WA",
        jobType: "Full-time",
        description:
            "Amazon is looking for a highly motivated software development engineer to join our team and help us build world-class products that delight our customers.",
        qualifications: [
          "Bachelor's degree in Computer Science or related field",
          "3+ years of experience in software development",
          "Proficiency in Java, Python, or C++",
          "Experience with AWS services is a plus",
          "Strong problem-solving skills",
          "Excellent communication skills",
        ],
        responsibilities: [
          "Design, develop, and deploy high-quality software using best practices",
          "Collaborate with cross-functional teams to build scalable and maintainable systems",
          "Write clean, efficient, and well-documented code",
          "Participate in code reviews and contribute to continuous improvement of our development processes",
          "Stay up-to-date with emerging trends and technologies in software development",
        ],
        datePosted: DateTime(2023, 2, 1),
        dateClosing: DateTime(2023, 3, 31),
        companyLogo:
            "https://companiesmarketcap.com/img/company-logos/64/AMZN.webp",
        salaryRange: '\$150,000 - \$180,000',
      ),
    ),
    JobApplication(
      id: 5,
      dateApplied: DateTime(2023, 3, 8),
      status: JobApplicationStatus.rejected,
      jobSeekerId: 1,
      jobPostingId: 2,
      jobPosting: JobPosting(
        title: "Senior Solutions Architect",
        company: "Amazon Web Services",
        location: "New York, NY",
        jobType: "Full-time",
        description:
            "Amazon Web Services is seeking a talented solutions architect to help our customers design and deploy cloud-based solutions that meet their business needs.",
        qualifications: [
          "Bachelor's or Master's degree in Computer Science or related field",
          "5+ years of experience in IT architecture, infrastructure, or software development",
          "Proficiency in at least one programming language (e.g., Java, Python, or Ruby)",
          "Experience with AWS services and technologies",
          "Strong communication and collaboration skills",
        ],
        responsibilities: [
          "Work with customers to understand their business requirements and design solutions that meet their needs",
          "Provide technical guidance and best practices to customers and internal teams",
          "Develop and maintain technical relationships with key customers and partners",
          "Contribute to the development of best practices and standards for cloud-based architecture and design",
          "Stay up-to-date with emerging trends and technologies in cloud computing",
        ],
        datePosted: DateTime(2023, 2, 15),
        dateClosing: DateTime(2023, 4, 30),
        companyLogo:
            "https://companiesmarketcap.com/img/company-logos/64/AMZN.webp",
        salaryRange: '\$150,000 - \$180,000',
      ),
    ),
    JobApplication(
      id: 3,
      dateApplied: DateTime(2022, 12, 22),
      status: JobApplicationStatus.rejected,
      jobSeekerId: 1,
      jobPostingId: 3,
      jobPosting: JobPosting(
        title: "iOS Developer",
        company: "Apple",
        location: "Cupertino, CA",
        jobType: "Full-time",
        description:
            "Apple is seeking an experienced iOS developer to help us build amazing products for our customers.",
        qualifications: [
          "Bachelor's or Master's degree in Computer Science or related field",
          "3+ years of experience in iOS development",
          "Proficiency in Swift and Objective-C",
          "Experience with UIKit, Core Data, and other iOS frameworks",
          "Excellent problem-solving skills",
          "Strong communication and collaboration skills",
        ],
        responsibilities: [
          "Design and implement new features for iOS applications",
          "Write clean, efficient, and well-documented code",
          "Collaborate with cross-functional teams to ensure high-quality product delivery",
          "Contribute to the development of best practices and standards for iOS development",
          "Stay up-to-date with emerging trends and technologies in iOS development",
        ],
        datePosted: DateTime(2023, 2, 1),
        dateClosing: DateTime(2023, 3, 31),
        companyLogo:
            "https://companiesmarketcap.com/img/company-logos/64/AAPL.webp",
        salaryRange: '\$150,000 - \$180,000',
      ),
    ),
  ];

  Map<DateTime, List<JobApplication>> mapJobApplicationsByDate(
      List<JobApplication> jobApplications) {
    final Map<DateTime, List<JobApplication>> jobApplicationsByDate = {};

    jobApplications.sort((a, b) => b.dateApplied.compareTo(a.dateApplied));

    for (final jobApplication in jobApplications) {
      final date = jobApplication.dateApplied;
      if (jobApplicationsByDate.containsKey(date)) {
        jobApplicationsByDate[date]?.add(jobApplication);
      } else {
        jobApplicationsByDate[date] = [jobApplication];
      }
    }

    return jobApplicationsByDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const JobApplicationChart(),
            const Text(
              'My Applications',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Column(
              children: mapJobApplicationsByDate(jobApplications)
                  .entries
                  .map((jobApplication) {
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
                      children: jobApplication.value
                          .map((jobApplication) =>
                              MyApplicationCard(jobApplication: jobApplication))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 8.0,
                    )
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}