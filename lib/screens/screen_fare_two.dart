import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ScreenFareTwo extends StatefulWidget {
  const ScreenFareTwo({super.key});

  @override
  State<ScreenFareTwo> createState() => _ScreenFareTwoState();
}

class _ScreenFareTwoState extends State<ScreenFareTwo> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  final db = FirebaseFirestore.instance;

  List? startPoints = [];
  List? endPoints = [];

  Future? sample() {
    db.collection('FareTable').get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          //startPoints?.add(docSnapshot.data()['StartPoint']);

          String? tempStart = docSnapshot.data()['StartPoint'];
          String? tempEnd = docSnapshot.data()['EndPoint'];

          if (startPoints?.contains(tempStart) != true) {
            startPoints?.add(tempStart);
          }

          if (endPoints?.contains(tempEnd) != true) {
            endPoints?.add(tempEnd);
          }

          print(startPoints);
          print(endPoints);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(66, 255, 252, 252)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text("Hello"),
                    onPressed: () {
                      sample();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
