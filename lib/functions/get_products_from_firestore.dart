import 'package:cloud_firestore/cloud_firestore.dart';



Future<Map> getProductNamesFromFirestore() async {
  final allProducts = {};

  //firestore reference for products
  final firestoreCollectionReference =
      await FirebaseFirestore.instance.collection('products').get();
  final firestoreDocuments = firestoreCollectionReference.docs;

  for (var i in firestoreDocuments) {
    allProducts[i.data()['name']] = i.data()['id'];
  }

  return allProducts;
}
