import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studen_db/utilities/dbService.dart';
import 'package:studen_db/models/student.dart';
import 'package:studen_db/utilities/appConstants.dart';
import 'package:studen_db/ui/studentForm.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryCol,
        title: Text('STUDENT LIST'),
      ),
      body: FutureBuilder<List<Student>>(
        future: StudentDBProvider.db.getAllStudentsFromLocalDb(),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Student st = snapshot.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                        title: Text(st.name.toString()),
                        leading: Icon(Icons.school,
                            size: 30, color: AppConstants.primaryCol),
                        trailing: Container(
                          width: MediaQuery.of(context).size.width / 3.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.edit,
                                      color: AppConstants.primaryCol),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                StudentForm(
                                                  isEdit: true,
                                                  student: st,
                                                )));
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete,
                                      color: AppConstants.primaryCol),
                                  onPressed: () {
                                    StudentDBProvider.db
                                        .deleteStudentFromLocalDb(st.id)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }),
                            ],
                          ),
                        )),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasData) {
            return Center(
              child: Container(
                child: Text('NO STUDENTS ADDED'),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
