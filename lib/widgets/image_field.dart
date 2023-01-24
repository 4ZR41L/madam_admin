import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ImageField extends StatelessWidget {

  final Controller controller = Get.find();
   ImageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: controller.imagePathController,
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
          prefixIcon: Icon(Icons.image, size: 14,),
          label: Text(
            "Şəkil",
            style: TextStyle(fontSize: 14),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
