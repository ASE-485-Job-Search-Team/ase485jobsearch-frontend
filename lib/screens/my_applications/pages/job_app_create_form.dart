import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/services/job_posting_service.dart';

import '../../../models/user.dart';
import '../../../services/auth_api_service.dart';

class JobApplicationPage extends StatefulWidget {
  final apiService;
  final jobPostingService;

  JobApplicationPage({required this.apiService, required this.jobPostingService});

  @override
  _JobApplicationPageState createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  late User _user;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();
  final TextEditingController _jobDescriptionController =
  TextEditingController();
  final TextEditingController _postedDateController = TextEditingController();
  final TextEditingController _closingDateController = TextEditingController();
  final TextEditingController _companyLogoURLController =
  TextEditingController();
  final TextEditingController _salaryRangeController = TextEditingController();

  List<TextEditingController> _qualificationControllers = [];
  List<TextEditingController> _responsibilitiesControllers = [];

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _postedDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    _qualificationControllers.add(TextEditingController());
    _responsibilitiesControllers.add(TextEditingController());
  }

  void _loadUserData() async {
    late User user;
    String response = await widget.apiService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];

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
        isAdmin: false,
      );
    }

    setState(() {
      _user = user;
    });
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyNameController.dispose();
    _locationController.dispose();
    _jobTypeController.dispose();
    _jobDescriptionController.dispose();
    _postedDateController.dispose();
    _closingDateController.dispose();
    _companyLogoURLController.dispose();
    _salaryRangeController.dispose();
    for (var controller in _qualificationControllers) {
      controller.dispose();
    }
    super.dispose();

    for (var controller in _responsibilitiesControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildResponsibilityFields() {
    List<Widget> fields = [];
    for (var i = 0; i < _responsibilitiesControllers.length; i++) {
      fields.addAll([
        TextFormField(
          decoration: InputDecoration(labelText: 'Responsibility'),
          controller: _responsibilitiesControllers[i],
          maxLines: null,
          keyboardType: TextInputType.multiline,
          validator: _validateNotEmpty,
        ),
        SizedBox(height: 16.0),
      ]);
    }
    fields.add(ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
      ),
      onPressed: () {
        setState(() {
          _responsibilitiesControllers.add(TextEditingController());
        });
      },
      icon: Icon(Icons.add),
      label: Text('Add Responsibility'),
    ));
    return Column(children: fields);
  }

  Widget _buildQualificationFields() {
    List<Widget> fields = [];
    for (var i = 0; i < _qualificationControllers.length; i++) {
      fields.addAll([
        TextFormField(
          decoration: InputDecoration(labelText: 'Qualifications'),
          controller: _qualificationControllers[i],
          maxLines: null,
          keyboardType: TextInputType.multiline,
          validator: _validateNotEmpty,
        ),
        SizedBox(height: 16.0),
      ]);
    }
    fields.add(ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
      ),
      onPressed: () {
        setState(() {
          _qualificationControllers.add(TextEditingController());
        });
      },
      icon: Icon(Icons.add),
      label: Text('Add Qualification'),
    ));
    return Column(children: fields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Job Application"),
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
                _buildQualificationFields(),
                SizedBox(height: 16.0),
                _buildResponsibilityFields(),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Posted Date',
                            suffixIcon: Icon(Icons.calendar_today, size: 16.0)),
                        controller: _postedDateController,
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Closing Date',
                            suffixIcon: Icon(Icons.calendar_today, size: 16.0)),
                        controller: _closingDateController,
                        validator: _validateNotEmpty,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (pickedDate != null) {
                            _closingDateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salary Range'),
                  controller: _salaryRangeController,
                  keyboardType: TextInputType.number,
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF2c3a6d)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.jobPostingService
                          .createJobPosting(
                              title: _jobTitleController.text,
                              companyId: _user.id,
                              location: _locationController.text,
                              jobType: _jobTypeController.text,
                              description: _jobDescriptionController.text,
                              qualifications: _qualificationControllers
                                  .map((controller) => controller.text)
                                  .toList(),
                              responsibilities: _responsibilitiesControllers
                                  .map((controller) => controller.text)
                                  .toList(),
                              datePosted: _postedDateController.text,
                              dateClosing: _closingDateController.text,
                              salaryRange: _salaryRangeController.text)
                          .then((value) => {})
                          .catchError((error) => {}); // Error handling here
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
