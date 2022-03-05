import 'package:cloud_firestore/cloud_firestore.dart';

void addvaccine() async {
  final _firestore = FirebaseFirestore.instance;
  CollectionReference _stocks = _firestore.collection('thunder squad');
  DocumentReference _stock = _stocks.doc("vaccine1");
  DocumentSnapshot snapshot = await _stock.get();
  _firestore
      .collection('thunder squad')
      .doc("vaccine1")
      .set({"temp": "40", "status": "Safe"});
}

fetchdetails(id) async {
  print("88888888888");
  print(id);
  final _firestore = FirebaseFirestore.instance;
  CollectionReference _stocks = _firestore.collection('thunder squad');
  DocumentReference _stock = _stocks.doc(id);
  DocumentSnapshot snapshot = await _stock.get();
  Map temp = snapshot.data();
  return temp;
}
