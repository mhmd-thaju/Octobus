import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

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
                      icon: const Icon(Icons.search),
                      label: const Text("Search Bus")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
