import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madam_admin/product.dart';

import '../controller.dart';

class AddProductButton extends StatelessWidget {
  AddProductButton({
    Key? key,
  }) : super(key: key);

  final Controller controller = Get.find();

  clearTextFields() {
    controller.imagePathController.text = '';
    controller.nameFieldController.text = '';
    controller.timeFieldController.text = '';
    controller.budgetFieldController.text = '';
    controller.caloriFieldController.text = '';
    controller.preparationStepController.text = '';
    controller.ingredientKeyController.text = '';
    controller.ingredientValueController.text = '';
    controller.relatedProducts.clear();
    controller.ingredients.clear();
    controller.preparation.clear();
    controller.selectedCategory.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          if (controller.nameFieldController.text.trim().isNotEmpty &&
              controller.imagePathController.text.trim().isNotEmpty &&
              controller.caloriFieldController.text.trim().isNotEmpty &&
              controller.budgetFieldController.text.trim().isNotEmpty &&
              controller.timeFieldController.text.trim().isNotEmpty &&
              controller.timeFieldController.text.trim().isNumericOnly &&
              controller.caloriFieldController.text.trim().isNumericOnly &&
              controller.budgetFieldController.text.trim().isNumericOnly &&
              controller.ingredients.isNotEmpty &&
              controller.preparation.isNotEmpty) {
            controller.preparation.add('Nuş olsun!');

            Product(
                    controller.nameFieldController.text.trim(),
                    controller.imagePathController.text.trim(),
                    controller.selectedCategory,
                    controller.selectedCountry,
                    controller.ingredients,
                    int.parse(controller.caloriFieldController.text.trim()),
                    int.parse(controller.budgetFieldController.text.trim()),
                    int.parse(controller.timeFieldController.text.trim()),
                    controller.preparation,
                    controller.relatedProducts)
                .addProduct();

            clearTextFields();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.indigo,
                content: const Text("Məhsul əlavə edildi!"),
                action: SnackBarAction(
                    label: "Oldu", textColor: Colors.white, onPressed: () {}),
              ),
            );
          } else {
            String snackBarText = '';

            if (controller.nameFieldController.text.trim().isEmpty) {
              snackBarText = "Məhsulun adı daxil edilməyib";
            } else if (controller.imagePathController.text.trim().isEmpty) {
              snackBarText = "Məhsulun şəkili daxil edilməyib";
            } else if (controller.ingredients.isEmpty) {
              snackBarText = "İstifad edilən ərzaqlar daxil edilməyib";
            } else if (controller.caloriFieldController.text.trim().isEmpty) {
              snackBarText = "Məhsulun kalori dəyəri daxil edilməyib";
            } else if (controller.timeFieldController.text.trim().isEmpty) {
              snackBarText = "Məhsulun hazırlanma vaxtı daxil edilməyib";
            } else if (controller.budgetFieldController.text.trim().isEmpty) {
              snackBarText = "Məhsulun maddi dəyəri daxil edilməyib";
            } else if (controller.preparation.isEmpty) {
              snackBarText = "Hazırlama mərhələləri daxil edilməyib";
            } else if (!controller.caloriFieldController.text.isNumericOnly) {
              snackBarText =
                  "Kalori dəyərinə yalnız rəqəm daxil edə bilərsiniz!";
            } else if (!controller.timeFieldController.text.isNumericOnly) {
              snackBarText =
                  "Bişirilmə müddətinə yalnız rəqəm daxil edə bilərsiniz!";
            } else if (!controller.budgetFieldController.text.isNumericOnly) {
              snackBarText =
                  "Büdcə indeksinə yalnız rəqəm daxil edə bilərsiniz!";
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
