import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class budgetField extends StatelessWidget {
  Controller controller = Get.find();

  budgetField({
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
          controller.budgetIndex = int.parse(value);
        },
      ),
    );
  }
}
