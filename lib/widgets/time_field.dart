import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class timeField extends StatelessWidget {
  Controller controller = Get.find();
   timeField({
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
          controller.cookingTime = int.parse(value);
        },
      ),
    );
  }
}
