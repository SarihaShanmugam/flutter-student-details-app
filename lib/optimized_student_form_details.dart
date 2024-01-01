
import 'package:flutter/material.dart';
import 'student_list_screen.dart';
import 'database_helper.dart';
import 'main.dart';
import 'student_details_model.dart';

class OptimizedStudentFormDetails extends StatefulWidget {
  const OptimizedStudentFormDetails({super.key});

  @override
  State<OptimizedStudentFormDetails> createState() => _OptimizedStudentFormDetailsState();
}

class _OptimizedStudentFormDetailsState extends State<OptimizedStudentFormDetails> {
  var _studentNameController = TextEditingController();
  var _studentMobNoController = TextEditingController();
  var _studentIdController = TextEditingController();
  var _studentAddressController = TextEditingController();

  bool firstTimeFlag = false;
  int _selectedId = 0;
  // Optimized
  String buttonText = 'Save';

  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  print('--------------> Cancel Button Clicked');
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print('--------------> Delete Button Clicked');
                  _delete();
                },
                child: const Text('Delete'),
              )
            ],
            title: const Text('Are you sure you want to delete this?'),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    if (firstTimeFlag == false) {
      print('once execute');

      firstTimeFlag = true;

      //final bankDetails = ModalRoute.of(context)!.settings.arguments as BankDetailsModel;
      final studentDetails = ModalRoute.of(context)!.settings.arguments;

      if(studentDetails == null) {
        print('Insert/Save:');
      } else {
        print('ListView: Received Data: Edit/Delete');

        studentDetails as StudentDetailsModel;

        print('Received Data');

        buttonText = 'Update';
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
}
    return Scaffold(
        appBar: AppBar(
        title: Text('student Account Details Form'),
    actions: _selectedId == 0 ? null :[
    PopupMenuButton<int>(
    itemBuilder: (context) => [
    PopupMenuItem(value: 1, child: Text("Delete")),
    ],
    elevation: 2,
    onSelected: (value) {
    if (value == 1) {
    print('Delete option clicked');
    _deleteFormDialog(context);
    }
    },
    ),
    ],
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
    labelText: 'Student Name',
    hintText: 'Enter Student Name'
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
    labelText: 'Student Mobile',
    hintText: 'Enter Student Mobile No'
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
    labelText: 'Student Id',
    hintText: 'Enter Student Id'
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
    labelText: 'Student Address',
    hintText: 'Enter Student Address'
    ),
    ),
    SizedBox(
    height: 30,
    ),
      ElevatedButton(
        onPressed: () {
          print('--------------> Update Button Clicked');
          if (_selectedId == 0) {
            print('---------------> Save');
            _save();
          } else {
            print('---------------> Update');
            _update();
          }
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

  void _save() async{
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

    final result = await dbHelper.insertStudentDetails(row);
    debugPrint('--------> Inserted Row Id: $result');

    if(result != 0) {
      _showSuccessSnackBar(context, 'Successfully Saved');
      backToListScreen();
    }else{
      _showSuccessSnackBar(context, 'Failed to save.');
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
    debugPrint('--------> Inserted Row Id: $result');

    if(result != 0) {
      _showSuccessSnackBar(context, 'Successfully updated');
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