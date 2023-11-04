import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '/firebase_stuff/auth_repo.dart';
import '/models/report_model.dart';

class ReportRepo extends GetxController {
  static ReportRepo get instance => Get.find();

  final _storage = FirebaseStorage.instance;
  final _db = FirebaseFirestore.instance;
  final _auth = Get.put((AuthRepo()));
  bool valuesChanged = false;
  List<ReportModel>? reports;

  Reference giveReference(String stringRef) {
    return _storage.ref(stringRef);
  }

  Future<List<ReportModel>> fetchReports({bool refreshValues = false}) async {
    if (reports == null || valuesChanged || refreshValues) {
      reports = await getReports();
      valuesChanged = false;
      return Future.delayed(Duration.zero, () => reports!);
    }
    return reports!;
  }

  Future<List<ReportModel>> getReports() async {
    String email = _auth.firebaseUser.value!.email!;

    final snapshot = await _db.collection("Reports").where("Email", isEqualTo: email).get();
    final testList = snapshot.docs.map((doc) => ReportModel.fromSnapshot(doc)).toList();
    return testList;
  }
}
