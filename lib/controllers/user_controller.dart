import 'package:eureka_learn/models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentController extends StateNotifier<Student> {
  final Reader _read;
  StudentController(this._read, Student student) : super(student);
  Student get student => Student(
      names: "James Doe",
      email: "workinguser@eureka-learn.cm",
      phone: "675622404",
      section: "Anglo",
      level: "top",
      avatar: "https://zety.com/about/michael-tomaszewski",
      school: "Zarathustra free Garoua",
      subjects: ["Maths", "Physics", "Biology", "Csc"],
      prenium: false,
      achievements: ["Star", "Bronz", "Alpha"]);
  set student(Student _student) => student = _student;
  Student getUser() {
    return student;
  }

  String getName() {
    return student.names;
  }
}

final studentControllerProvider =
    StateNotifierProvider<StudentController, Student>((ref) =>
        StudentController(
            ref.read,
            Student(
                names: "Jeanne Doe",
                email: "jeannedoe@eureka-learn.cm",
                phone: "698098787",
                section: "Franco",
                level: "top",
                avatar: "https://zety.com/about/michael-tomaszewski",
                school: "GBHS Garoua",
                subjects: ["Maths", "Physics", "Biology", "Csc"],
                prenium: false,
                achievements: ["Star", "Bronz", "Alpha"])));
