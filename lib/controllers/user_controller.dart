import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentController extends StateNotifier<Student> {
  final Reader _read;
  StudentController(this._read, Student student) : super(student);
  Student get student => student;
  set student(Student _student) => student = _student;

  void edit() {
    _read(databaseProvider).getUser("id");
  }

  String test(int x) {
    return "Loremson ipsumson $x";
  }
}

final studentControllerProvider =
    StateNotifierProvider.autoDispose<StudentController, Student>(
        (ref) => StudentController(ref.read, Student.initial()));
