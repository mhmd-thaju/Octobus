import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  Widget _selectedArea(
      {required Color color,
      required String title,
      required String subtitile,
      required String image}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.only(left: 10),
      height: 220,
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            width: 125,
            height: 150,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitile,
            style: TextStyle(fontSize: 15, color: Colors.black),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Welcome to OctoBus",
          style: TextStyle(
            fontFamily: 'LobsterTwo',
            fontSize: 32,
            fontStyle: FontStyle.italic,
            color: Color.fromARGB(255, 12, 138, 240),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsetsDirectional.only(top: 15),
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 60, 159, 240),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Padding(
                padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Column(
                  children: [
                    Text(
                      '''OctoBus is a Bus Monitoring App developed to asisst people those who uses bus form transportation in "Kerala"''',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      height: 554.635,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          image: DecorationImage(
                              image: AssetImage("asset/images/octobus.png"),
                              fit: BoxFit.fitWidth,
                              opacity: 199),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(01.0),
                              spreadRadius: 5,
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        children: [
                          Text(
                            "Our Team :-",
                            style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  _selectedArea(
                                      color: Colors.white.withOpacity(0.7),
                                      subtitile: "3488",
                                      title: "Aasim Mohammed",
                                      image: 'asset/images/Aasim.jpg'),
                                  _selectedArea(
                                      color: Colors.white.withOpacity(0.7),
                                      subtitile: "3414",
                                      title: "Shyam Kiran",
                                      image: 'asset/images/shyam.jpg'),
                                  _selectedArea(
                                      color: Colors.white.withOpacity(0.7),
                                      subtitile: "3401",
                                      title: "Anjali Krishna",
                                      image: 'asset/images/anjali.jpg'),
                                  _selectedArea(
                                      color: Colors.white.withOpacity(0.7),
                                      subtitile: "3408",
                                      title: '''Muhammed Thajudheen''',
                                      image: 'asset/images/thaju.jpeg'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                          Text(
                              '''App is currently in development Please wait for new features in the future updates''')
                        ],
                      ),
                    ),
                  ],
                ),
              )

              //decoration: BoxDecoration(color: Colors.blue),
              ),
        ),
      ),
    );
  }
}



// Column(
//                 children: const [
//                   Text(
//                     "Welcome to OctoBus",
//                     style: TextStyle(
//                       fontFamily: 'LobsterTwo',
//                       fontSize: 32,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   Text("adasd")
//                 ],
//               ),