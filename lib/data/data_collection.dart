import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class dataCollectionProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> equipmentList = {};
  Future<void> getEquipment() async {
    DocumentSnapshot snap = await _firestore
        .collection("Equipment")
        .doc("7Wjrm3jLHO0DHqD7OQ5L")
        .get();
    equipmentList = snap.data() as Map<String, dynamic>;
  }

  Future<void> updateList(String equipment, String name) async {
    equipmentList["equipment"] = name;
    print("Hi man");
    await _firestore
        .collection("Equipment")
        .doc("7Wjrm3jLHO0DHqD7OQ5L")
        .update({"$equipment": "$name"});
    print("Hi man");
    notifyListeners();
  }
}
