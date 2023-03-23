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
  final TextEditingController _postedDateController = TextEditingController();
  final TextEditingController _closingDateController = TextEditingController();
  final TextEditingController _companyLogoURLController = TextEditingController();
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
    _postedDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    _qualificationControllers.add(TextEditingController());
    _responsibilitiesControllers.add(TextEditingController());
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
                  decoration: InputDecoration(
                      labelText: 'Company Name based on logged in user'),
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
                _buildQualificationFields(),
                SizedBox(height: 16.0),
                _buildResponsibilityFields(),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Posted Date'),
                        controller: _postedDateController,
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Closing Date'),
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
                  decoration: InputDecoration(labelText: 'Company Logo URL'),
                  controller: _companyLogoURLController,
                  keyboardType: TextInputType.url,
                  validator: _validateNotEmpty,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
// Submit job application
// ...
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