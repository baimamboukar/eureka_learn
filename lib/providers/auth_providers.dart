import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:eureka_learn/services/services.dart';

final firebaseAuthProvider = StateProvider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final authProvider = StateProvider<Authentication>((ref) {
  return Authentication(ref.read(firebaseAuthProvider).state, ref.read);
});

final authStateProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.watch(authProvider).state.authStateChanges);
