import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<String>((ref) => "");
final emailProvider = StateProvider<String>((ref) => "");
final passwordProvider = StateProvider<String>((ref) => "");
final phoneProvider = StateProvider<String>((ref) => "");
final registrationInfosProvider = StateProvider<bool>((ref) => false);
final sectionProvider = StateProvider<String>((ref) => "");
final classeProvider = StateProvider<String>((ref) => "");
final subjectsProvider = StateProvider<List<String>>((ref) => []);
final levelProvider = StateProvider<String>((ref) => "");
