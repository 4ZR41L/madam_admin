import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Product {
  late String id;
  final String name;
  final String imagePath;
  final String category;
  final String country;
  final List relatedProducts;
  RxList ingredients;
  final int calori;
  final int budgetIndex;
  final int cookingTime;
  final RxList preparation;

  Product(
      this.name,
      this.imagePath,
      this.category,
      this.country,
      this.ingredients,
      this.calori,
      this.budgetIndex,
      this.cookingTime,
      this.preparation,
      this.relatedProducts);

  void addProduct() async {
    // we create instanse for 'products collection'
    final firestoreCollection =
        FirebaseFirestore.instance.collection('products');

    // we create instance for document in products collection. in doc() method if we type name in String format it will be our document's id
    // but if we left it empty, document ID will be generated automatically
    final firestoreDocument = firestoreCollection.doc();

    //it is recommended that to keep document ID as data also
    id = firestoreDocument.id;

    //we create json data of new product from entered informations
    final jsonData = {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'category': category,
      'country': country,
      'ingredients': ingredients,
      'calori': calori,
      'budgetIndex': budgetIndex,
      'cookingTime': cookingTime,
      'preparation': preparation,
      'relatedProducts': relatedProducts
    };

    // with this method we create new document with specified data
    await firestoreDocument.set(jsonData);
  }
}
