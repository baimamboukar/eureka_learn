import 'package:eureka_learn/models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentController extends StateNotifier<Student?> {
  final Reader _read;
  StudentController(this._read, Student student) : super(student);
  Student get student => student ?? Student.initial();
  set student(Student _student) => student = _student;
  Student getUser() {
    return student;
  }

  String test(int x) {
    return "Loremson ipsumson $x";
  }
}

final studentControllerProvider =
    StateNotifierProvider<StudentController, Student?>(
        (ref) => StudentController(ref.read, Student.initial()));
