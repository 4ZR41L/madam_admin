import 'package:cloud_firestore/cloud_firestore.dart';



Future<Map> getProductNamesFromFirestore() async {
  final allProducts = {};

  //firestore reference for products
  final firestoreCollectionReference =
      await FirebaseFirestore.instance.collection('products').get();
  final firestoreDocuments = firestoreCollectionReference.docs;

  for (var i in firestoreDocuments) {

    //we create a Map with name:id pairs because the names will shown on related products list and when user select an item, we will need it's id for referencing it
    allProducts[i.data()['name']] = i.data()['id'];
  }


  return allProducts;
}
