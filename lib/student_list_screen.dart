
import 'package:flutter/material.dart';
import 'optimized_student_form_details.dart';
import 'database_helper.dart';
import 'main.dart';
import 'student_form_details.dart';
import 'student_details_model.dart';

class StudentDetailsListScreen extends StatefulWidget {
  const StudentDetailsListScreen({super.key});

  @override
  State<StudentDetailsListScreen> createState() =>
      _StudentDetailsListScreenState();
}

class _StudentDetailsListScreenState extends State<StudentDetailsListScreen> {
  List<StudentDetailsModel> _studentDetailsList = <StudentDetailsModel>[];

  @override
  void initState() {
    super.initState();
    print('------> initState');
    _getStudentDetailsRecords();
  }

  _getStudentDetailsRecords() async {
    var _studentDetailsRecords = await dbHelper.getStudentDetails();
//iterate
    _studentDetailsRecords.forEach((studentDetailRow) {
      setState(() {
        print(studentDetailRow[DataBaseHelper.columnId]);
        print(studentDetailRow[DataBaseHelper.columnStudentName]);
        print(studentDetailRow[DataBaseHelper.columnStudentMobNo]);
        print(studentDetailRow[DataBaseHelper.columnStudentId]);
        print(studentDetailRow[DataBaseHelper.columnStudentAddress]);
String value=studentDetailRow[DataBaseHelper.columnStudentId]!=null?studentDetailRow[DataBaseHelper.columnStudentId]:"";
        var _StudentDetailsModel = StudentDetailsModel(
          studentDetailRow[DataBaseHelper.columnId],
          studentDetailRow[DataBaseHelper.columnStudentName],
          studentDetailRow[DataBaseHelper.columnStudentMobNo],
          value,
          studentDetailRow[DataBaseHelper.columnStudentAddress],
        );
        _studentDetailsList.add(_StudentDetailsModel);
      });
    });
  }

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
      body: Container(
        child: ListView.builder(
            itemCount: _studentDetailsList.length,
            itemBuilder: (BuildContext, int index) {
              return InkWell(
                onTap: () {
                  print('---------->Edit or Delete invoked: Send Data');
                  print(_studentDetailsList[index].id);
                  print(_studentDetailsList[index].StudentName);
                  print(_studentDetailsList[index].StudentMobNo);
                  print(_studentDetailsList[index].StudentId);
                  print(_studentDetailsList[index].StudentAddress);
                 /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditStudentDetailsFormScreen(),
                    settings: RouteSettings(
                      arguments: _studentDetailsList[index],
                    ),
                  ));*/

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OptimizedStudentFormDetails(),
                    settings: RouteSettings(
                      arguments: _studentDetailsList[index],
                    ),
                  ));

                },
                child: ListTile(
                  title: Text(_studentDetailsList[index].StudentName +
                      '\n' +
                      _studentDetailsList[index].StudentMobNo +
                      '\n' +
                      _studentDetailsList[index].StudentId +
                      '\n' +
                      _studentDetailsList[index].StudentAddress),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('=======>Student details');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StudentDetailsFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
