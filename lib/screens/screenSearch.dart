import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromARGB(66, 255, 252, 252)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    //controller: _username,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Start Point"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Destination"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        //checkLogin(context);
                      },
                      icon: Icon(Icons.search),
                      label: Text("Search Bus")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
