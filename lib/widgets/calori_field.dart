import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class CaloryField extends StatelessWidget {

  final Controller controller = Get.find();

   CaloryField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        controller: controller.caloriFieldController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text(
              'Kalori',
              style: TextStyle(fontSize: 10),
            ),
            suffixText: 'kal.',suffixStyle: TextStyle(fontSize: 8),
            prefixIcon: Icon(
              Icons.scale_outlined,
              size: 12,
            )),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,

      ),
    );
  }
}
