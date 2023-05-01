import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_core/firebase_core.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  List<DropDownValueModel> travelPoints = [];

  List localData = [];

  late SingleValueDropDownController selectedJourney;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });

    selectedJourney = SingleValueDropDownController();
  }

  @override
  void dispose() {
    selectedJourney.dispose();
    super.dispose();
  }

  final db = FirebaseFirestore.instance;

  Future<void>? sample() {
    db.collection('BusDetails').get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          String tempStart = docSnapshot.data()['StartPoint'];
          String tempEnd = docSnapshot.data()['EndPoint'];

          if (!localData.contains(docSnapshot.data())) {
          localData.add(docSnapshot.data());
          }

          print("localData = $localData");
          print("localData.length = ${localData.length}");

          DropDownValueModel temp1 = DropDownValueModel(
            name: "$tempStart -> $tempEnd",
            value: tempStart,
          );

          print(temp1);

          // DropDownValueModel temp2 = DropDownValueModel(
          //   name: tempEnd,
          //   value: tempEnd,
          // );

          if (travelPoints.contains(temp1) != true) {
            print("temp 1 = $temp1");
            travelPoints.add(temp1);
          }

          print("travelpoints = $travelPoints");
          //print(endPoints);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return null;
  }

  Future<List<dynamic>>? searchBus(selectedJourney) async {
    print("inside searchbus");

    var matchNames = localData.where(
      (element) => element["StartPoint"] == selectedJourney,
    );

    List result = matchNames.toList();

    return result;
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
                    padding: const EdgeInsets.all(25),
                    controller: selectedJourney,
                    clearOption: true,
                    enableSearch: true,
                    textFieldDecoration: const InputDecoration.collapsed(
                      hintText: 'Select Journey',
                    ),
                    searchDecoration: const InputDecoration(
                      hintText: "Select Journey",
                      labelText: "Select Journey",
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownList: travelPoints,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      print("onpressedlocaldata: $localData");
                      setState(
                        () {
                          searchBus(selectedJourney.dropDownValue?.value);
                        },
                      );
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("Search Bus"),
                  ),
                  SingleChildScrollView(
                    child: FutureBuilder(
                      future: searchBus(
                        selectedJourney.dropDownValue?.value,
                      ),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot,
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
                        } else if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
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
