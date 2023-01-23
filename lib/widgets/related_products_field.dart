import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'constants.dart';

class RelatedProductField extends StatelessWidget {
  const RelatedProductField({
    Key? key,
    required this.productNames,
    required this.relatedProducts,
    required this.allProducts,
  }) : super(key: key);

  final List<String> productNames;
  final List relatedProducts;
  final List allProducts;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      searchable: true,
      searchHint: 'Axtar',
      cancelText: const Text("Ləğv et"),
      confirmText: const Text('Seç'),



      items: [
        for (var i in productNames)
          MultiSelectItem(productNames.indexOf(i), i),
      ],
      title:  Text("Məhsullar"),
      selectedColor: Colors.blue,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius:
        BorderRadius.all(Radius.circular(40)),
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
        relatedProducts.clear();

        for(var i in results){
          relatedProducts.add(allProducts[i].id);
        }
        print(relatedProducts);


        //_selectedAnimals = results;
      },
    );
  }
}
