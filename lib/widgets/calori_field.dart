import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class caloryField extends StatelessWidget {

  Controller controller = Get.find();

   caloryField({
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
          controller.calori = int.parse(value);
        },
      ),
    );
  }
}
