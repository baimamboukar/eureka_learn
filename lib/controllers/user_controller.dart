import 'package:eureka_learn/models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentController extends StateNotifier<Student> {
  final Reader _read;
  StudentController(this._read, Student student) : super(student);
  Student get student => state;
  //set student(Student _student) => student = _student;
  set data(Student _student) => state = _student;

  void printUser() {
    print(state);
  }

  String getName() {
    return state.names;
  }
}

final studentControllerProvider =
    StateNotifierProvider<StudentController, Student>((ref) =>
        StudentController(
            ref.read,
            Student(
                names: "Jean18113ne Doe",
                email: "jeannedoe@eureka-learn.cm",
                phone: "698098787",
                section: "Franco",
                level: "top",
                avatar: "https://zety.com/about/michael-tomaszewski",
                school: "GBHS Garoua",
                subjects: ["Maths", "Physics", "Biology", "Csc"],
                prenium: false,
                achievements: ["Star", "Bronz", "Alpha"])));
