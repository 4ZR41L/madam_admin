import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class TimeField extends StatelessWidget {
  final Controller controller = Get.find();

  TimeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        controller: controller.timeFieldController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text(
              'Müddət',
              style: TextStyle(fontSize: 10),
            ),
            suffixText: 'dəq.',
            suffixStyle: TextStyle(fontSize: 8),
            prefixIcon: Icon(
              Icons.timer,
              size: 12,
            )),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
