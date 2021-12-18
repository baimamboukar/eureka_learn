import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final Reader _read;
  Database(this._read);

  //=====*****USER AUTHENTICATION*****=====//
  Future<bool> createUser(
      {required String id, required Student student}) async {
    try {
      _firestore
          .collection('students')
          .doc(id)
          .set(Student.toDocumentSnapshot(student))
          .then((_) async {
        getUser(id);
      });

      return true;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      return false;
    }
  }

  bool getUser(String uid) {
    try {
      _firestore
          .collection('students')
          .doc(uid)
          .get(GetOptions(source: Source.serverAndCache))
          .then((doc) {
        Student _student = Student.fromDocumentSnapshot(doc.data());
        _read(studentControllerProvider.notifier).data = _student;
      });
      return true;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      return false;
    }
  }

  //=====*****END USER AUTH*****=====//

//=======****POSTS****================//

  bool post(PostModel post) {
    try {
      _firestore
          .collection('posts')
          .doc()
          .set(PostModel.toDocumentSnapshot(post))
          .then((posted) {
        Toast.toast(
            color: Palette.success,
            title: "No error",
            message: "No error",
            icon: LineIcons.checkCircle);
      });

      return true;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      return false;
    }
  }

  //======*****END POST*****======//

  // String uploadMedia(File media, String path) {
  //   storage.ref().child(path).putFile(media).then((response){
  //     response.
  //   });
  // }

  Stream getUserPapers(Student user) {
    try {
      Stream papers = _firestore
          .collection("papers")
          .where("level", isEqualTo: user.level)
          .snapshots();
      return papers;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
  }

  Future<void> getUserFeeds() async {
    try {
      List<PostModel> timeline = [];
      _firestore.collection('posts').get().then((snapshot) {
        print(PostModel.fromDocumentSnapshot(snapshot.docs.first.data()));
        snapshot.docs.forEach((doc) {
          timeline.add(PostModel.fromDocumentSnapshot(doc.data()));
        });
      });
      _read(postsControllerProvider.notifier).data = timeline;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
    }
  }

  Stream getUserBooks(Student user) {
    try {
      Stream papers = _firestore
          .collection("books")
          .where("subject", whereIn: user.subjects)
          .where("tags", arrayContainsAny: user.subjects)
          .where("tags", arrayContainsAny: user.achievements)
          .snapshots();
      return papers;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
  }
}
