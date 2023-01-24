import 'package:flutter/material.dart';

class PreparationHeader extends StatelessWidget {
  const PreparationHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        "Hazırlanma addımları: ",
        style: TextStyle(
            color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
