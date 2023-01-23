import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class imageField extends StatelessWidget {

  Controller controller = Get.find();
   imageField({
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
        onChanged: (value) {
          controller.imagePath = value.toString();
        },
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
