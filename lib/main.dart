import 'package:flutter/material.dart';
import 'package:madam_admin/add_new_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Madam Admin',

      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:  const AddNewProductScreen(),
    );
  }
}
