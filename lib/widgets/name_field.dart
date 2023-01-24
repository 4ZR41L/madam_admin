import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class NameFiled extends StatelessWidget {
  final Controller controller = Get.find();
   NameFiled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: controller.nameFieldController,
        textAlign: TextAlign.start,
        enabled: true,
        autofocus: true,
        cursorColor: Colors.indigo,
        maxLines: 1,
        showCursor: true,
        keyboardType: TextInputType.text,

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
