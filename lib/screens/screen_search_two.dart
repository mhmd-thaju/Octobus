import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class ScreenSearchTwo extends StatefulWidget {
  const ScreenSearchTwo({super.key});

  @override
  State<ScreenSearchTwo> createState() => _ScreenSearchTwoState();
}

class _ScreenSearchTwoState extends State<ScreenSearchTwo> {
  List<DropDownValueModel> travelPoints = [];

  List localData = [];
  List searchResults = [];

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
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');

          String tempStart = docSnapshot.data()['StartPoint'];
          String tempEnd = docSnapshot.data()['EndPoint'];

          if (!localData.any((data) => const DeepCollectionEquality()
              .equals(data, docSnapshot.data()))) {
            localData.add(docSnapshot.data());
          }

          localData = localData.toSet().toList();

          DropDownValueModel temp1 = DropDownValueModel(
            name: "$tempStart -> $tempEnd",
            value: [tempStart, tempEnd],
          );

          if (travelPoints.contains(temp1) != true) {
            travelPoints.add(temp1);
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return null;
  }

  Future<dynamic> searchBus(arg1, arg2) async {
    var matchNames = localData.where(
      (element) => element["StartPoint"] == arg1 && element["EndPoint"] == arg2,
    );

    List<dynamic> matchNamesList = matchNames.toList();

    if (matchNames.isNotEmpty) {
      return matchNamesList;
    } else {
      return [-1];
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
              child: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      DropDownTextField(
                        padding: const EdgeInsets.all(15),
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
                          var result =
                              await searchBus("Pattambi", "Perinthalmanna");
                          setState(() {
                            searchResults = result;
                          });
                        },
                        icon: const Icon(Icons.search),
                        label: const Text("Search Bus"),
                      ),
                      FutureBuilder(
                        future: Future.value(searchResults),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
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
                          } else if (snapshot.hasData &&
                              snapshot.data != [-1]) {
                            snapshot.data.sort((a, b) {
                              DateTime aStartTime = a['StartTime']
                                  .toDate()
                                  .add(const Duration(hours: 5, minutes: 30));
                              DateTime bStartTime = b['StartTime']
                                  .toDate()
                                  .add(const Duration(hours: 5, minutes: 30));
                              return aStartTime.compareTo(bStartTime);
                            });
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var busDetails = snapshot.data[index];

                                var startTime = busDetails['StartTime']
                                    .toDate()
                                    .add(const Duration(hours: 5, minutes: 30));
                                var endTime = busDetails['EndTime']
                                    .toDate()
                                    .add(const Duration(hours: 5, minutes: 30));
                                var startTimeString =
                                    DateFormat('MMM d, y h:mm a')
                                        .format(startTime);
                                var endTimeString =
                                    DateFormat('MMM d, y h:mm a')
                                        .format(endTime);

                                return Card(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Bus Name: ${busDetails['BusName']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Start Time: $startTimeString',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'End Time: $endTimeString',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
