// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

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

  String? selectedCategory = "Ət yeməkləri";
  String newIngredientKey = '';
  String newIngredientValue = '';
  List<String> preparation = ['Sahil', 'Mikayil', "Rail"];
  String preparationStep = ' ';
  int preparationStepIndex = 100;

  List<Map> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.done_outline_sharp)),
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
                  SizedBox(
                    height: 60,
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(5),

                      children: [
                        ingredientsField(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        const timeField(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        const caloryField(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        const budgetField(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        categorySelector()
                      ],
                    ),
                  ),
                  ingredientsList(),
                  const preparationHeader(),
                  preparationField(context),
                  preparationList(context),
                ],
              ),
            ),
          ],
        ),
      ),),
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
            width: MediaQuery.of(context).size.width * 0.7,
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
              onPressed: () {
                if (preparationStep != ' ') {
                  if (preparationStepIndex == 100) {
                    preparation.add(preparationStep);
                  } else {
                    preparation[preparationStepIndex] = preparationStep;
                  }

                  setState(() {
                    preparationStep = ' ';
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
          width: 140,
          child: TextField(
            controller: TextEditingController(text: newIngredientKey),
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Ərzaq"),
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
          width: 140,
          child: TextField(
            controller: TextEditingController(text: newIngredientValue),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Miqdar"),
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
      width: 140,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Büdcə"),
          suffixText: '/ 5',
          prefixIcon: Icon(Icons.scale_outlined),
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 1,
        textAlign: TextAlign.center,
        onSubmitted: (value) {},
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
      width: 140,
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Kalori'),
            suffixText: 'kal.',
            prefixIcon: Icon(Icons.scale_outlined)),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
        onSubmitted: (value) {},
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
      width: 140,
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Müddət'),
            suffixText: 'dəq.',
            prefixIcon: Icon(Icons.timer)),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
        onSubmitted: (value) {},
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
        onSubmitted: (value) {},
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
        onSubmitted: (value) {},
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
