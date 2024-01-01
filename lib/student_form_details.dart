

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'optimized_student_form_details.dart';
import 'database_helper.dart';
import 'main.dart';
import 'student_list_screen.dart';

class StudentDetailsFormScreen extends StatefulWidget {
  const StudentDetailsFormScreen({super.key});

  @override
  State<StudentDetailsFormScreen> createState() => _StudentDetailsFormScreenState();
}

class _StudentDetailsFormScreenState extends State<StudentDetailsFormScreen> {
  var _studentNameController = TextEditingController();
  var _studentMobNoController = TextEditingController();
  var _studentIdController = TextEditingController();
  var _studentAddressController = TextEditingController();
  bool firstTimeFlag = false;
  int _selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _studentNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  //  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Student Name',
                  hintText: 'Enter Student Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _studentMobNoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  labelText: 'Student Mobile No',
                  hintText: 'Enter Mobile No',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _studentIdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  labelText: 'Student ID',
                  hintText: 'Enter Student ID',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _studentAddressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  labelText: 'Student Address',
                  hintText: 'Enter Student Address',
                ),
              ),
              SizedBox(
                height: 15,
              ),

              ElevatedButton(
                onPressed: () {
                  print('======> Save Button Clicked');
                  _save();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    print('=====>Student Name: ${_studentNameController.text}');
    print('====>Student Mob No: ${_studentMobNoController.text}');
    print('====>student Id : ${_studentIdController.text}');
    print('====>student Address : ${_studentAddressController.text}');


    Map<String, dynamic> row = {
      DataBaseHelper.columnStudentName: _studentNameController.text,
      DataBaseHelper.columnStudentMobNo: _studentMobNoController.text,
      DataBaseHelper.columnStudentId: _studentIdController.text,
      DataBaseHelper.columnStudentAddress: _studentAddressController.text,

    };

    final result = await dbHelper.insertStudentDetails(row);

    debugPrint('Inserted Row Id: $result');

    _showSuccessSnacksBar(this.context, 'Saved Successfully');

    setState(() {
      Navigator.of(this.context).pushReplacement(
          MaterialPageRoute(builder: (context) => StudentDetailsListScreen()));
    });
  }

  void _showSuccessSnacksBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
