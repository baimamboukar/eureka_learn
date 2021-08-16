import 'package:eureka_learn/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentStudentProvider =
    StateProvider<Student>((ref) => Student.initial());
