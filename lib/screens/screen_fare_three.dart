import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ScreenFareThree extends StatefulWidget {
  const ScreenFareThree({super.key});

  @override
  State<ScreenFareThree> createState() => _ScreenFareThreeState();
}

class _ScreenFareThreeState extends State<ScreenFareThree> {
  List<DropDownValueModel> startPoints = [];
  List<DropDownValueModel> endPoints = [];

  List localData = [];

  late SingleValueDropDownController selectedStart;
  late SingleValueDropDownController selectedEnd;
  late int queryFare;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
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
          //print('${docSnapshot.id} => ${docSnapshot.data()}');
          String tempStart = docSnapshot.data()['StartPoint'];
          String tempEnd = docSnapshot.data()['EndPoint'];
          localData.add(docSnapshot.data());
          //print(localData);

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

          //print(startPoints);
          //print(endPoints);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return null;
  }

  Future<int> search(selectedStart, selectedEnd) async {
    var matchNames = localData.where(
      (element) =>
          element["StartPoint"] == selectedStart &&
          element["EndPoint"] == selectedEnd,
    );

    print("matchNames = $matchNames");

    if (matchNames.isNotEmpty) {
      var fare = matchNames.first["Fare"];
      return fare;
    } else {
      return 0;
    }
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
                    padding: const EdgeInsets.all(15),
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
                        color: Colors.blue,
                      ),
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
                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(
                        () {
                          search(selectedStart.dropDownValue?.value,
                              selectedEnd.dropDownValue?.value);
                        },
                      );
                    },
                    icon: const Icon(Icons.paid_outlined),
                    label: const Text("Calculate Fare"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: FutureBuilder(
                      future: search(selectedStart.dropDownValue?.value,
                          selectedEnd.dropDownValue?.value),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<int> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.black,
                            ),
                          );
                        } else if (snapshot.hasData && snapshot.data != 0) {
                          return Text(
                            'The fare is\n\nRs. ${snapshot.data}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
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
