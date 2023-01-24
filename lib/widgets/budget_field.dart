import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class BudgetField extends StatelessWidget {
  final Controller controller = Get.find();

  BudgetField({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        controller: controller.budgetFieldController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text(
            "Büdcə",
            style: TextStyle(fontSize: 10),
          ),
          suffixText: '/ 5',suffixStyle: TextStyle(fontSize: 8),
          prefixIcon: Icon(Icons.attach_money, size: 12,),
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 1,
        textAlign: TextAlign.center,

      ),
    );
  }
}
