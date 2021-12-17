import 'package:eureka_learn/controllers/user_controller.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentControllerProvider =
    StateNotifierProvider.autoDispose<StudentController, Student>(
        (ref) => StudentController(ref.read, Student.initial()));
