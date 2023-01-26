import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  List relatedProducts = [];
  RxList ingredients = [].obs;
  RxList preparation = [].obs;
  String selectedCategory = "Ət yeməkləri";
  String selectedCountry = "Milli mətbəx";
  RxInt allProductsCount = 0.obs;

  final imagePathController = TextEditingController();
  final nameFieldController = TextEditingController();
  final timeFieldController = TextEditingController();
  final budgetFieldController = TextEditingController();
  final caloriFieldController = TextEditingController();
  final preparationStepController = TextEditingController();

  final ingredientKeyController = TextEditingController();
  final ingredientValueController = TextEditingController();
}
