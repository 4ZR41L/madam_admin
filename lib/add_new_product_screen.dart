import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madam_admin/controller.dart';
import 'package:madam_admin/widgets/add_new_product_button.dart';
import 'package:madam_admin/widgets/budget_field.dart';
import 'package:madam_admin/widgets/calori_field.dart';
import 'package:madam_admin/widgets/constants.dart';
import 'package:madam_admin/widgets/image_field.dart';
import 'package:madam_admin/widgets/name_field.dart';
import 'package:madam_admin/widgets/preparation_header.dart';
import 'package:madam_admin/widgets/time_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'functions/get_products_from_firestore.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  Controller controller = Get.put(Controller());
  final List<String> categories = [
    "Ət yeməkləri",
    "Toyuq yeməkləri",
    "Balıq yeməkləri",
    "Dietik yeməklər",
  ];

  int preparationStepIndex = 100;

  //FireStore settings
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Iterable<dynamic> productNames;
  Map<dynamic, dynamic> allProducts = {};

  Future<Iterable> getProductNames() async {
    allProducts = await getProductNamesFromFirestore();
    productNames = allProducts.keys;
    controller.allProductsCount.value = allProducts.length;

    setState(() {});

    return productNames;
  }

  @override
  void initState() {
    //call this function and add as list to related products dropdown select
    getProductNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddProductButton(),
      backgroundColor: primaryColor100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView(
            children: [
              Obx(() => Text(
                  'Yeni məhsul əlavə edin (${controller.allProductsCount})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: NameFiled()),
                        Expanded(
                          child: ImageField(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        categorySelector(),
                      ],
                    ),
                    MultiSelectDialogField(
                      separateSelectedItems: true,
                      searchable: true,
                      searchHint: 'Axtar',
                      cancelText: const Text("Ləğv et"),
                      confirmText: const Text('Seç'),
                      items: [
                        for (var i in allProducts.keys) MultiSelectItem(i, i)
                      ],
                      title: const Text("Məhsullar"),
                      selectedColor: Colors.indigo,
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: primaryColor!,
                          width: 1,
                        ),
                      ),
                      buttonIcon: const Icon(Icons.chevron_right),
                      buttonText: const Text(
                        "Əlaqəli məhsullar",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        controller.relatedProducts.clear();

                        for (var i in results) {
                          controller.relatedProducts.add(allProducts[i]);
                        }

                        //_selectedAnimals = results;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ingredientsField(),
                    ingredientsList(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TimeField(),
                        CaloryField(),
                        BudgetField(),
                      ],
                    ),
                    const PreparationHeader(),
                    preparationField(context),
                    preparationList(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx preparationList(BuildContext context) {
    return Obx(() => ListView(
          padding: const EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            for (var i in controller.preparation)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(i.toString()),
                  shape: const RoundedRectangleBorder(),
                  textColor: Colors.white,
                  tileColor: primaryColor300,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              controller.preparation.remove(i);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              controller.preparationStepController.text = i;

                              preparationStepIndex =
                                  controller.preparation.indexOf(i);
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              )
          ],
        ));
  }

  Padding preparationField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              controller: controller.preparationStepController,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              onPressed: () {
                if (controller.preparationStepController.text
                    .trim()
                    .isNotEmpty) {
                  if (preparationStepIndex == 100) {
                    controller.preparation
                        .add(controller.preparationStepController.text);
                  } else {
                    controller.preparation[preparationStepIndex] =
                        controller.preparationStepController.text;
                  }

                  setState(() {
                    controller.preparationStepController.text = '';
                    preparationStepIndex == 100;
                  });
                }
              },
              child: const SizedBox(height: 50, child: Icon(Icons.add)),
            ),
          ),
        ],
      ),
    );
  }

  Padding ingredientsList() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        height: 50,
        child: Obx(() => ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in controller.ingredients)
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    shape: const StadiumBorder(),
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.ingredients.remove(i);
                                  });
                                },
                                icon: const Icon(
                                  Icons.clear_rounded,
                                  color: Colors.white,
                                  size: 25,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                " ${i.values.first} ${i.keys.first}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }

  Row ingredientsField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            controller: controller.ingredientKeyController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Ərzaq",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            keyboardType: TextInputType.text,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '-',
            style: TextStyle(fontSize: 30, color: primaryColor),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            controller: controller.ingredientValueController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Miqdar",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            keyboardType: TextInputType.text,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
            color: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            onPressed: () {
              if (controller.ingredientKeyController.text.trim().isNotEmpty &&
                  controller.ingredientValueController.text.trim().isNotEmpty) {
                setState(() {
                  controller.ingredients.add({
                    controller.ingredientKeyController.text:
                        controller.ingredientValueController.text
                  });
                });
                controller.ingredientKeyController.text = '';
                controller.ingredientValueController.text = '';
              }
            },
            icon: const Icon(Icons.done_all))
      ],
    );
  }

  DropdownButton<String> categorySelector() {
    return DropdownButton<String>(
      menuMaxHeight: 300,
      alignment: Alignment.center,
      value: controller.selectedCategory,
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          controller.selectedCategory = value!;
        });
      },
    );
  }
}
