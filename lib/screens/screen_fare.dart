import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database';

/* void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScreenFare());
} */

class ScreenFare extends StatefulWidget {
  const ScreenFare({super.key});

  @override
  State<ScreenFare> createState() => _ScreenFareState();
}

class _ScreenFareState extends State<ScreenFare> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  String selected_start_point = "0";
  String selected_end_point = "0";

  final firebaseRef = FirebaseDatabase.instance.reference().child("FareTable");

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
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Start Point"),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("FareTable")
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<DropdownMenuItem> startPoint = [];
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        final starting_points =
                            snapshot.data?.docs.reversed.toList();
                        startPoint.add(
                          DropdownMenuItem(
                            value: "0",
                            child: Text('Enter Start Point'),
                          ),
                        );
                        for (var starting in starting_points!) {
                          startPoint.add(
                            DropdownMenuItem(
                              value: starting.id,
                              child: Text(
                                starting['StartPoint'],
                              ),
                            ),
                          );
                        }
                      }
                      return DropdownButton(
                        items: startPoint,
                        onChanged: (startingvalue) {
                          setState(() {
                            selected_start_point = startingvalue;
                          });
                          print(startingvalue);
                        },
                        value: selected_start_point,
                        isExpanded: true,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter End Point"),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("FareTable")
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<DropdownMenuItem> endPoint = [];
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        final ending_points =
                            snapshot.data?.docs.reversed.toList();
                        endPoint.add(
                          DropdownMenuItem(
                            value: "0",
                            child: Text('Enter End Point'),
                          ),
                        );
                        for (var ending in ending_points!) {
                          endPoint.add(
                            DropdownMenuItem(
                              value: ending.id,
                              child: Text(
                                ending['EndPoint'],
                              ),
                            ),
                          );
                        }
                      }
                      return DropdownButton(
                        items: endPoint,
                        onChanged: (endingvalue) {
                          setState(() {
                            selected_end_point = endingvalue;
                          });
                          print(endingvalue);
                        },
                        value: selected_end_point,
                        isExpanded: true,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        //checkLogin(context);
                      },
                      icon: const Icon(Icons.monetization_on_outlined),
                      label: const Text("Calculate Fare")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
