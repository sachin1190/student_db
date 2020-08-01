import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studen_db/utilities/appConstants.dart';
import 'package:studen_db/utilities/constantFields.dart';
import 'package:studen_db/utilities/dbService.dart';
import 'package:studen_db/models/student.dart';

class StudentForm extends StatefulWidget {
  final bool isEdit;
  final Student student;

  StudentForm({this.student, this.isEdit = false});

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  Student _student = new Student();

  TextEditingController nameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> studentForm = new GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearControllers();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppConstants.secondaryCol,
                onPressed: () {
                  clearControllers();
                  Navigator.pushNamed(context, '/studentList');
                },
                child: Icon(Icons.edit, color: AppConstants.primaryCol)),
            body: Center(
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 40,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height / 1.1,
                  decoration: BoxDecoration(
                      color: AppConstants.primaryCol,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: SingleChildScrollView(
                    child: Form(
                      key: studentForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: widget.isEdit
                                ? Text(
                                    'EDIT STUDENT  DETAILS',
                                    style: TextStyle(
                                        color: AppConstants.secondaryCol,
                                        fontSize: 18),
                                  )
                                : Text(
                                    'ENTER STUDENT  DETAILS',
                                    style: TextStyle(
                                        color: AppConstants.secondaryCol,
                                        fontSize: 18),
                                  ),
                          ),
                          getTextFieldLarge(
                              nameController,
                              widget.isEdit
                                  ? widget.student.name
                                  : 'Enter Name'),
                          getTextFieldLarge(
                              fathersNameController,
                              widget.isEdit
                                  ? widget.student.fathersName
                                  : 'Enter Father\'s Name'),
                          Row(
                            children: [
                              getTextFieldSmall(
                                  cityController,
                                  widget.isEdit
                                      ? widget.student.city
                                      : 'Enter city',
                                  TextInputType.text),
                              getTextFieldSmall(
                                  zipController,
                                  widget.isEdit
                                      ? widget.student.zip
                                      : 'Enter zip',
                                  TextInputType.number),
                            ],
                          ),
                          getTextFieldLarge(
                              addressController,
                              widget.isEdit
                                  ? widget.student.address
                                  : 'Enter Address'),
                          getPhoneField(
                              phoneController,
                              widget.isEdit
                                  ? widget.student.phone
                                  : 'Enter Phone'),
                          Row(
                            children: [
                              getTextFieldSmall(
                                  dobController,
                                  widget.isEdit
                                      ? widget.student.dob
                                      : 'Enter DOB',
                                  TextInputType.datetime),
                              IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: AppConstants.secondaryCol,
                                  ),
                                  onPressed: _pickDate)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: RaisedButton(
                                onPressed: widget.isEdit
                                    ? () {
                                        Map updateMap = new Map();

                                        if (nameController.text.isNotEmpty)
                                          updateMap['name'] =
                                              nameController.text;
                                        if (fathersNameController
                                            .text.isNotEmpty)
                                          updateMap['fathersName'] =
                                              fathersNameController.text;
                                        if (addressController.text.isNotEmpty)
                                          updateMap['address'] =
                                              addressController.text;
                                        if (phoneController.text.isNotEmpty)
                                          updateMap['phone'] =
                                              phoneController.text;
                                        if (zipController.text.isNotEmpty)
                                          updateMap['zip'] = zipController.text;
                                        if (cityController.text.isNotEmpty)
                                          updateMap['city'] =
                                              cityController.text;
                                        if (dobController.text.isNotEmpty)
                                          updateMap['dob'] = dobController.text;

                                        StudentDBProvider.db
                                            .updateStudent(Map.from(updateMap),
                                                widget.student.id)
                                            .then((value) {
                                          navigate();
                                        });
                                      }
                                    : () {
                                        if (studentForm.currentState
                                            .validate()) {
                                          _student.id =
                                              DateTime.now().toString();
                                          _student.name = nameController.text;
                                          _student.fathersName =
                                              fathersNameController.text;
                                          _student.phone = phoneController.text;
                                          _student.zip = zipController.text;
                                          _student.city = cityController.text;
                                          _student.address =
                                              addressController.text;
                                          _student.dob = dobController.text;

                                          print('success');
                                          StudentDBProvider.db
                                              .saveStudent(_student)
                                              .then((value) {
                                            navigate();
                                          });
                                        }
                                      },
                                color: AppConstants.secondaryCol,
                                child: Text('Save'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 25),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        dobController.text =
            '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
      });
    }
  }

  navigate() {
    clearControllers();
    Navigator.pushNamed(context, '/studentList');
  }

  clearControllers() {
    nameController.clear();
    addressController.clear();
    fathersNameController.clear();
    cityController.clear();
    zipController.clear();
    dobController.clear();
    phoneController.clear();
  }
}
