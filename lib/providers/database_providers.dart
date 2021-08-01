import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/services/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fireStoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final databaseProvider =
    Provider<Database>((ref) => Database(ref.read(fireStoreProvider)));
