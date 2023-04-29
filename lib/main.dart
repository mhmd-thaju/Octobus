import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:octobus/screens/login_view_two.dart';
import 'package:octobus/screens/screen_fare_three.dart';
import 'package:octobus/screens/screen_home.dart';
import 'package:octobus/screens/screen_search.dart';
import 'package:octobus/screens/running_status.dart';
import 'package:octobus/screens/login_view.dart';
import 'package:octobus/screens/register_view.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginDemo(),
        routes: {
          '/login/': (context) => const LoginDemo(),
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
            if (user == null) {
              return const LoginView();
            } else {
              return const MainView();
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
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ScreenOne(),
    ScreenSearch(),
    RunningStatus(),
    ScreenFareThree(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OctoBus"),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(
          //     Icons.account_circle,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pushNamedAndRemoveUntil(
          //       '/login/',
          //       (route) => false,
          //     );
          //   },
          // ),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Running Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid_outlined),
            label: 'Fare',
          ),
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
