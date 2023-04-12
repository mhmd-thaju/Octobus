import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ScreenFareTwo extends StatefulWidget {
  const ScreenFareTwo({super.key});

  @override
  State<ScreenFareTwo> createState() => _ScreenFareTwoState();
}

class _ScreenFareTwoState extends State<ScreenFareTwo> {
  List<DropDownValueModel> startPoints = [];
  List<DropDownValueModel> endPoints = [];

  late SingleValueDropDownController selectedStart;
  late SingleValueDropDownController selectedEnd;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

    selectedStart = SingleValueDropDownController();
    selectedEnd = SingleValueDropDownController();
  }

  @override
  void dispose() {
    selectedStart.dispose();
    selectedEnd.dispose();
    super.dispose();
  }

  final db = FirebaseFirestore.instance;

  Future<void>? sample() {
    db.collection('FareTable').get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          String tempStart = docSnapshot.data()['StartPoint'];
          String tempEnd = docSnapshot.data()['EndPoint'];

          DropDownValueModel temp1 = DropDownValueModel(
            name: tempStart,
            value: tempStart,
          );

          DropDownValueModel temp2 = DropDownValueModel(
            name: tempEnd,
            value: tempEnd,
          );

          if (startPoints.contains(temp1) != true) {
            startPoints.add(temp1);
          }

          if (endPoints.contains(temp2) != true) {
            endPoints.add(temp2);
          }

          print(startPoints);
          print(endPoints);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    sample();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(66, 255, 252, 252)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  DropDownTextField(
                    padding: EdgeInsets.all(15),
                    controller: selectedStart,
                    clearOption: true,
                    enableSearch: true,
                    textFieldDecoration: const InputDecoration.collapsed(
                      hintText: 'Select Start Point',
                    ),
                    searchDecoration: const InputDecoration(
                      hintText: "Select Start Point",
                      labelText: "Select Start Point",
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownList: startPoints,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'TO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.blue),
                    ),
                  ),
                  DropDownTextField(
                    padding: const EdgeInsets.all(25),
                    controller: selectedEnd,
                    clearOption: true,
                    enableSearch: true,
                    textFieldDecoration: const InputDecoration.collapsed(
                      hintText: 'Select End Point',
                    ),
                    searchDecoration: const InputDecoration(
                      hintText: "Select End Point",
                      labelText: "Select End Point",
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownList: endPoints,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
