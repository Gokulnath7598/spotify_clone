import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/redux/reducers.dart';
import 'mainpage1.dart';
import 'model/app_state.dart';
import 'search.dart';
import 'library.dart';
import 'premium.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

Future<void> main() async {
  final _initState = AppState(name: 'Gocool', mail: 'gocool7598@gmail.com');
  final Store<AppState> _store = Store<AppState>(reducer,initialState: _initState);
  runApp(Myapp(store: _store));
}
// void main()=> runApp(const Myapp());

class Myapp extends StatelessWidget {
  final Store<AppState> store;
  const Myapp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData.dark(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
        // Color.fromARGB(1,128,0,128),
        Colors.purple,
        Colors.black,
        ], begin: Alignment.topLeft, end: FractionalOffset(0.3, 0.3)),
    ),
    child: show(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          onTap: ((int x) {
            setState(() {
              index = x;
              show(index);
            });
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Your Library',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.spotify),
              label: 'Premium',
            ),
          ]),
      // ),
    );
  }
}

Widget show(int index) {
  switch (index) {
    case 0:
      return const MainPage();
    case 1:
      return const SSearch();
    case 2:
      return const Library();
    case 3:
      return const Premium();
  }
  return const MainPage();
}
