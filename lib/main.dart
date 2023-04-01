import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:octobus/screens/ScreenFare.dart';
//import 'package:octobus/screen1.dart';
import 'package:octobus/screens/screenHome.dart';
import 'package:octobus/screens/screenSearch.dart';
import 'package:octobus/views/login_view.dart';
import 'package:octobus/views/login_view_two.dart';
import 'package:octobus/views/register_view.dart';
import 'package:octobus/views/verify_email_view.dart';
//import '';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainView(),
        routes: {
          '/login/': (context) => const LoginView(),
          '/register/': (context) => const RegisterView(),
          '/main/': (context) => const MainView(),
        }),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const MainView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // final _textController = TextEditingController();
  // final _textControllers = TextEditingController();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ScreenOne(),
    ScreenSearch(),
    ScreenFare(),
    // Text(
    //   'Index 3: Settings',
    //   style: optionStyle,
    // ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      //print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const GNav(
      //   backgroundColor: Color.fromARGB(255, 179, 171, 171),
      //   color: Color.fromARGB(255, 5, 6, 6),
      //   activeColor: Color.fromARGB(255, 179, 171, 171),
      //   tabBackgroundColor: Color.fromARGB(255, 61, 59, 59),
      //   padding: EdgeInsets.all(15),
      //   gap: 8,
      //   tabs: [
      //     GButton(
      //       icon: Icons.home,
      //       text: 'Home',
      //     ),
      //     GButton(
      //       icon: Icons.search,
      //       text: 'Search',
      //     ),
      //     GButton(
      //       icon: Icons.paid,
      //       text: 'Fare',
      //     ),
      //     // GButton(
      //     //   icon: Icons.person,
      //     //   text: 'Account',
      //     // ),
      //   ],

      // ),
      appBar: AppBar(
        title: const Text("OctoBus"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                      (_) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Log Out"),
                )
              ];
            },
          )
        ],
      ),
      // body: SafeArea(
      //     child: Padding(
      //   padding: EdgeInsets.all(20),
      //   child: Container(
      //     decoration: BoxDecoration(
      //         color: Colors.grey, borderRadius: BorderRadius.circular(5)),
      //     child: Column(
      //       children: [
      //         TextField(
      //           controller: _textController,
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(),
      //             hintText: "Enter starting point",
      //           ),
      //         ),
      //         SizedBox(height: 30),
      //         TextField(
      //           controller: _textControllers,
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(),
      //             hintText: "Enter destination point",
      //           ),
      //         ),
      //         ElevatedButton(onPressed: () {}, child: Text("Enter")),
      //         //SizedBox(height: 100),
      //       ],
      //     ),
      //   ),
      // )),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            //backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid_outlined),
            label: 'Fare',
            //backgroundColor: Colors.blue,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          //   backgroundColor: Colors.pink,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Log out "),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login/',
                  (route) => false,
                );
              },
              child: const Text('Yes')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
