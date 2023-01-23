// ignore_for_file: camel_case_types

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
import 'package:madam_admin/widgets/related_products_field.dart';
import 'package:madam_admin/widgets/time_field.dart';

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

  String? selectedCategory = "Ət yeməkləri";
  List<Map> ingredients = [];
  List<String> preparation = [];


  String newIngredientKey = '';
  String newIngredientValue = '';
  String preparationStep = '';
  int preparationStepIndex = 100;
  List relatedProducts = [];

  //FireStore settings
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static var productsDatabase;
  static List<String> productNames = [];
  static List allProducts = [];

  Future<void> getProductsList() async {
    productsDatabase = await firestore.collection('products').get();

    allProducts = productsDatabase.docs;

    for (var i in allProducts) {
      productNames.add(i['name']);
    }

    setState(() {});
  }

  @override
  void initState() {
    getProductsList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddProductButton(
        ingredients: ingredients,
        preparation: preparation,
        productsDatabase: productsDatabase,
        selectedCategory: selectedCategory,
      ),
      backgroundColor: primaryColor100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView(
            children: [
              Text('Yeni məhsul əlavə edin:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
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
                        Expanded(child: nameFiled()),
                        Expanded(
                          child: imageField(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        categorySelector(),
                        RelatedProductField(
                            productNames: productNames,
                            relatedProducts: relatedProducts,
                            allProducts: allProducts),
                      ],
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
                        timeField(),
                        caloryField(),
                        budgetField(),
                      ],
                    ),
                    const preparationHeader(),
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

  ListView preparationList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        for (var i in preparation)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(i.toString()),
              shape: const RoundedRectangleBorder(),
              textColor: Colors.white,
              tileColor: primaryColor300   ,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          preparation.remove(i);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          preparationStep = i;

                          preparationStepIndex = preparation.indexOf(i);
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
    );
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
              controller: TextEditingController(text: preparationStep),
              onChanged: (value) => preparationStep = value,
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
                if (preparationStep != '') {
                  if (preparationStepIndex == 100) {
                    preparation.add(preparationStep);
                  } else {
                    preparation[preparationStepIndex] = preparationStep;
                  }

                  setState(() {
                    preparationStep = '';
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
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var i in ingredients)
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
                                ingredients.remove(i);
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
        ),
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
            controller: TextEditingController(text: newIngredientKey),
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
            onChanged: (value) {
              newIngredientKey = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '-',
            style: TextStyle(fontSize: 30, color: primaryColor),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            controller: TextEditingController(text: newIngredientValue),
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
            onChanged: (value) {
              newIngredientValue = value;
            },
          ),
        ),
        IconButton(
            color: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            onPressed: () {
              if (newIngredientKey != '' && newIngredientValue != '') {
                setState(() {
                  ingredients.add({newIngredientKey: newIngredientValue});
                });
                newIngredientKey = '';
                newIngredientValue = '';
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
      value: selectedCategory,
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
        });
      },
    );
  }
}
