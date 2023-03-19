import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobApplicationPage extends StatefulWidget {
  @override
  _JobApplicationPageState createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _qualificationsController = TextEditingController();
  final TextEditingController _responsibilitiesController = TextEditingController();
  final TextEditingController _postedDateController = TextEditingController();
  final TextEditingController _closingDateController = TextEditingController();
  final TextEditingController _companyLogoURLController = TextEditingController();
  final TextEditingController _salaryRangeController = TextEditingController();

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _postedDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyNameController.dispose();
    _locationController.dispose();
    _jobTypeController.dispose();
    _jobDescriptionController.dispose();
    _qualificationsController.dispose();
    _responsibilitiesController.dispose();
    _postedDateController.dispose();
    _closingDateController.dispose();
    _companyLogoURLController.dispose();
    _salaryRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Application'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Job Title'),
                  controller: _jobTitleController,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company Name based on logged in user'),
                  controller: _companyNameController,
                  validator: _validateNotEmpty,
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  controller: _locationController,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Job Type'),
                  controller: _jobTypeController,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Job Description'),
                  controller: _jobDescriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Qualifications'),
                  controller: _qualificationsController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Responsibilities'),
                  controller: _responsibilitiesController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date Posted: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}'),
                  controller: _postedDateController,
                  validator: _validateNotEmpty,
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Closing Date (YYYY-MM-DD)'),
                  controller: _closingDateController,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company Logo URL'),
                  controller: _companyLogoURLController,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salary Range'),
                  controller: _salaryRangeController,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> jsonData = {
                        'jobTitle': _jobTitleController.text,
                        'company': "Company Name Based on Logged in User/Company",
                        'location': _locationController.text,
                        'jobType': _jobTypeController.text,
                        'jobDescription': _jobDescriptionController.text,
                        'qualifications': _qualificationsController.text,
                        'responsibilities': _responsibilitiesController.text,
                        'datePosted': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        'closingDate': _closingDateController.text,
                        'companyLogoURL': _companyLogoURLController.text,
                        'salaryRange': _salaryRangeController.text,
                      };
                      print(jsonData);
                      // Send jsonData to database
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}