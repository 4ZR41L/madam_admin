import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  List relatedProducts = [];
  RxList ingredients = [].obs;
  RxList preparation = [].obs;
  List <String?> selectedCategory = ["Ət yeməkləri"];
  String selectedCountry = "AZE";
  RxInt allProductsCount = 0.obs;
  RxString imagePath = 'https://images.squarespace-cdn.com/content/v1/53b839afe4b07ea978436183/1608506169128-S6KYNEV61LEP5MS1UIH4/traditional-food-around-the-world-Travlinmad.jpg'.obs;

  final imagePathController = TextEditingController();
  final nameFieldController = TextEditingController();
  final timeFieldController = TextEditingController();
  final budgetFieldController = TextEditingController();
  final caloriFieldController = TextEditingController();
  final preparationStepController = TextEditingController();

  final ingredientKeyController = TextEditingController();
  final ingredientValueController = TextEditingController();
}
