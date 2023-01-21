import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseTest extends StatefulWidget {
  const FirebaseTest({Key? key}) : super(key: key);

  @override
  State<FirebaseTest> createState() => _FirebaseTestState();
}


class _FirebaseTestState extends State<FirebaseTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                  child: const TextField()),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const TextField()),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: () async{

                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference productsDatabase = firestore.collection('products');
                // productsDatabase.add({'key': ['C', 'D']});

                var data = await productsDatabase.get();
                for(var i in data.docs){
                  var subData = i.data();
                  print(subData);


                }





              }, child: const Text('OK')),
              const Text('data')
            ],
          ),
        ),
      ),
    );
  }
}
