// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final List<String> categories = [
    "Ət yeməkləri",
    "Toyuq yeməkləri",
    "Balıq yeməkləri",
    "Dietik yeməklər",
  ];

  static String? name;
  static String? imagePath;
  String? selectedCategory = "Ət yeməkləri";
  List<Map> ingredients = [];
  List<String> preparation = [];
  static int? calori;
  static int? budgetIndex;
  static int? cookingTime;

  String newIngredientKey = '';
  String newIngredientValue = '';
  String preparationStep = '';
  int preparationStepIndex = 100;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static var productsDatabase;
  static List<String> products = [];

  Future <void> getProductsList() async {

    //ToDo there is some error, need to fix
    productsDatabase = await firestore.collection('products');
    var productsList = await productsDatabase!.get();

    for (var i  in productsList){
      products.add(i!['name']);
    }


    print(productsList!.docs[0]!['name']);


  }

  @override
  void initState() {

    getProductsList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (name != null &&
                imagePath != null &&
                calori != null &&
                budgetIndex != null &&
                cookingTime != null &&
                ingredients.isNotEmpty &&
                preparation.isNotEmpty) {
              productsDatabase.add({
                'name': name,
                'imagePath': imagePath,
                'calori': calori,
                'budgetIndex': budgetIndex,
                'cookingTime': cookingTime,
                'category': selectedCategory,
                'ingredients': ingredients,
                'preparation': preparation
              });
            } else {
              String snackBarText = '';

              if (name == null) {
                snackBarText = "Məhsulun adı daxil edilməyib";
              } else if (imagePath == null) {
                snackBarText = "Məhsulun şəkili daxil edilməyib";
              } else if (ingredients.isEmpty) {
                snackBarText = "İstifad edilən ərzaqlar daxil edilməyib";
              } else if (calori == null) {
                snackBarText = "Məhsulun kalori dəyəri daxil edilməyib";
              } else if (cookingTime == null) {
                snackBarText = "Məhsulun hazırlanma vaxtı daxil edilməyib";
              } else if (budgetIndex == null) {
                snackBarText = "Məhsulun maddi dəyəri daxil edilməyib";
              } else if (preparation.isEmpty) {
                snackBarText = "Hazırlama mərhələləri daxil edilməyib";
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.indigo,
                  content:
                      Text('Bütün bölmələr doldurulmalıdır: $snackBarText'),
                  action: SnackBarAction(
                      label: "Oldu", textColor: Colors.white, onPressed: () {}),
                ),
              );
            }
          },
          child: const Icon(Icons.done_outline_sharp)),
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView(
            children: [
              const Text('Yeni məhsul əlavə edin:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.indigo,
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
                      children: const [
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
                        MultiSelectDialogField(
                          searchable: true,
                          items: [
                            for (var i in products)
                              MultiSelectItem(products.indexOf(i), i),
                          ],
                          title: const Text("Məhsullar"),
                          selectedColor: Colors.blue,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.indigo,
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
                            //_selectedAnimals = results;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    ingredientsField(),
                    ingredientsList(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
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
              tileColor: Colors.indigo[300],
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
                color: Colors.indigo[500],
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '-',
            style: TextStyle(fontSize: 30, color: Colors.indigo),
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
            color: Colors.indigo,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            onPressed: () {
              setState(() {
                ingredients.add({newIngredientKey: newIngredientValue});
              });
              newIngredientKey = '';
              newIngredientValue = '';
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

class preparationHeader extends StatelessWidget {
  const preparationHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        "Hazırlanma addımları: ",
        style: TextStyle(
            color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class budgetField extends StatelessWidget {
  const budgetField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text(
            "Büdcə",
            style: TextStyle(fontSize: 12),
          ),
          suffixText: '/ 5',
          prefixIcon: Icon(Icons.scale_outlined),
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 1,
        textAlign: TextAlign.center,
        onChanged: (value) {
          _AddNewProductScreenState.budgetIndex = int.parse(value);
        },
      ),
    );
  }
}

class caloryField extends StatelessWidget {
  const caloryField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text(
              'Kalori',
              style: TextStyle(fontSize: 12),
            ),
            suffixText: 'kal.',
            prefixIcon: Icon(
              Icons.scale_outlined,
              size: 18,
            )),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
        onChanged: (value) {
          _AddNewProductScreenState.calori = int.parse(value);
        },
      ),
    );
  }
}

class timeField extends StatelessWidget {
  const timeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text(
              'Müddət',
              style: TextStyle(fontSize: 12),
            ),
            suffixText: 'dəq.',
            prefixIcon: Icon(
              Icons.timer,
              size: 18,
            )),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
        onChanged: (value) {
          _AddNewProductScreenState.cookingTime = int.parse(value);
        },
      ),
    );
  }
}

class imageField extends StatelessWidget {
  const imageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        textAlign: TextAlign.start,
        enabled: true,
        autofocus: true,
        cursorColor: Colors.indigo,
        maxLines: 1,
        showCursor: true,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          _AddNewProductScreenState.imagePath = value.toString();
        },
        expands: false,
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.image),
          label: Text(
            "Şəkil",
            style: TextStyle(fontSize: 20),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class nameFiled extends StatelessWidget {
  const nameFiled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        textAlign: TextAlign.start,
        enabled: true,
        autofocus: true,
        cursorColor: Colors.indigo,
        maxLines: 1,
        showCursor: true,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          _AddNewProductScreenState.name = value.toString();
        },
        expands: false,
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: const InputDecoration(
          label: Text(
            "Adı",
            style: TextStyle(fontSize: 20),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
