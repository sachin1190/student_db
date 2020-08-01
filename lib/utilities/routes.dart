import 'package:studen_db/ui/loginPage.dart';
import 'package:studen_db/ui/studentForm.dart';
import 'package:studen_db/ui/studentList.dart';

getRoutes() {
  return {
    '/': (context) => LoginPage(),
    '/studentForm': (context) => StudentForm(),
    '/studentList': (context) => StudentList()
  };
}
