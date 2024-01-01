
/*import 'package:bank_project/student_details_model.dart';
import 'package:bank_project/student_list_screen.dart';
import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'main.dart';

class EditStudentDetailsFormScreen extends StatefulWidget {
  const EditStudentDetailsFormScreen({super.key});

  @override
  State<EditStudentDetailsFormScreen> createState() => _EditStudentDetailsFormScreenState();
}

class _EditStudentDetailsFormScreenState extends State<EditStudentDetailsFormScreen> {
  var _studentNameController = TextEditingController();
  var _studentMobNoController = TextEditingController();
  var _studentIdController = TextEditingController();
  var _studentAddressController = TextEditingController();


  // Edit mode
  bool firstTimeFlag = false;
  int _selectedId = 0;

  @override
  Widget build(BuildContext context) {

    // Edit - Receive Data
    if (firstTimeFlag == false) {
      print('---------->once execute');

      firstTimeFlag = true;

      final studentDetails = ModalRoute.of(context)!.settings.arguments as StudentDetailsModel;

      print('----------->Received Data');
      print(studentDetails.id);
      print(studentDetails.StudentName);
      print(studentDetails.StudentMobNo);
      print(studentDetails.StudentId);
      print(studentDetails.StudentAddress);

      _selectedId = studentDetails.id!;
      _studentNameController.text = studentDetails.StudentName;
      _studentMobNoController.text = studentDetails.StudentMobNo;
      _studentIdController.text = studentDetails.StudentId;
      _studentAddressController.text = studentDetails.StudentAddress;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details Edit Form'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _studentNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Bank Name',
                      hintText: 'Enter Bank Name'
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _studentMobNoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Branch Name',
                      hintText: 'Enter Branch Name'
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account Type',
                      hintText: 'Enter Account Type'
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _studentAddressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account No',
                      hintText: 'Enter Account No'
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('--------------> Update Button Clicked');
                    _update();
                  },
                  child: Text('Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _update() async{
    print('--------------> _update');
    print('---------------> Selected ID: $_selectedId');
    print('--------------> Student Name: ${_studentNameController.text}');
    print('--------------> Student Mob no: ${_studentMobNoController.text}');
    print('--------------> StudentId Type: ${_studentIdController.text}');
    print('--------------> Student Address No: ${_studentAddressController.text}');


    Map<String, dynamic> row = {
      DataBaseHelper.columnId: _selectedId,
      DataBaseHelper.columnStudentName: _studentNameController.text,
      DataBaseHelper.columnStudentMobNo: _studentMobNoController.text,
      DataBaseHelper.columnStudentId: _studentIdController.text,
      DataBaseHelper.columnStudentAddress: _studentAddressController.text,

    };

    final result = await dbHelper.updateStudentDetails(row);
    debugPrint('--------> Updated Row Id: $result');
    _showSuccessSnackBar(context, 'Successfully Updated');
    setState(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
          (context) => StudentDetailsListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }
}
void _update() async{
  print('--------------> _update');
  print('---------------> Selected ID: $_selectedId');
  print('--------------> Student Name: ${_studentNameController.text}');
  print('--------------> Student Mob no: ${_studentMobNoController.text}');
  print('--------------> StudentId Type: ${_studentIdController.text}');
  print('--------------> Student Address No: ${_studentAddressController.text}');


  Map<String, dynamic> row = {
    DataBaseHelper.columnId: _selectedId,
    DataBaseHelper.columnStudentName: _studentNameController.text,
    DataBaseHelper.columnStudentMobNo: _studentMobNoController.text,
    DataBaseHelper.columnStudentId: _studentIdController.text,
    DataBaseHelper.columnStudentAddress: _studentAddressController.text,

  };

  final result = await dbHelper.updateStudentDetails(row);
  debugPrint('--------> Updated Row Id: $result');

  if(result != 0) {
    _showSuccessSnackBar(context, 'Successfully Updated');
    backToListScreen();
  }else{
    _showSuccessSnackBar(context, 'Failed to update.');
  }
}

void _delete() async{
  print('--------------> _delete');

  final result = await dbHelper.deleteStudentDetails(_selectedId);

  debugPrint('-----------------> Deleted Row Id: $result');

  if(result != 0) {
    _showSuccessSnackBar(context, 'Successfully Deleted.');
    backToListScreen();
  }else{
    _showSuccessSnackBar(context, 'Failed to delete.');
  }
}

backToListScreen(){
  setState(() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => StudentDetailsListScreen()));
  });
}

void _showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(message)));
}
}
*/