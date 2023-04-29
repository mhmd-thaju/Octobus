import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Screen")),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(66, 255, 252, 252),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ]),
          padding: const EdgeInsets.all(0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Welcome To OctoBus ",
                  style: TextStyle(
                    fontFamily: 'LobsterTwo',
                    fontSize: 36.0,
                    //fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 18, 140, 239),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                Text("Our Team :- "),
                Text(''' 
                Anjaly Krishna --
                Muhammed Thajudheen --
                Shyam Kiran --
                Aasim Mohammed --AL MAIN
                

                Supervising by:-    Luttapi😈(SK)
                '''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
