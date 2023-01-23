import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class AddProductButton extends StatelessWidget {

  AddProductButton({
    Key? key,

    required this.ingredients,
    required this.preparation,
    required this.productsDatabase,
    required this.selectedCategory,
  }) : super(key: key);

  final List<Map> ingredients;
  final List<String> preparation;
  final productsDatabase;
  final String? selectedCategory;
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          if (controller.name != '' &&
              controller.imagePath != '' &&
              controller.calori != 0 &&
              controller.budgetIndex != 0 &&
              controller.cookingTime != 0 &&
              ingredients.isNotEmpty &&
              preparation.isNotEmpty) {
            productsDatabase.add({
              'name': controller.name,
              'imagePath': controller.imagePath,
              'calori': controller.calori,
              'budgetIndex': controller.budgetIndex,
              'cookingTime': controller.cookingTime,
              'category': selectedCategory,
              'ingredients': ingredients,
              'preparation': preparation,
              //"relatedProducts" : relatedProducts
            });
          } else {
            String snackBarText = '';

            if (controller.name == '') {
              snackBarText = "Məhsulun adı daxil edilməyib";
            } else if (controller.imagePath == '') {
              snackBarText = "Məhsulun şəkili daxil edilməyib";
            } else if (ingredients.isEmpty) {
              snackBarText = "İstifad edilən ərzaqlar daxil edilməyib";
            } else if (controller.calori == 0) {
              snackBarText = "Məhsulun kalori dəyəri daxil edilməyib";
            } else if (controller.cookingTime == 0) {
              snackBarText = "Məhsulun hazırlanma vaxtı daxil edilməyib";
            } else if (controller.budgetIndex == 0) {
              snackBarText = "Məhsulun maddi dəyəri daxil edilməyib";
            } else if (preparation.isEmpty) {
              snackBarText = "Hazırlama mərhələləri daxil edilməyib";
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.indigo,
                content: Text('Bütün bölmələr doldurulmalıdır: $snackBarText'),
                action: SnackBarAction(
                    label: "Oldu", textColor: Colors.white, onPressed: () {}),
              ),
            );
          }
        },
        child: const Icon(Icons.done_outline_sharp));
  }
}
