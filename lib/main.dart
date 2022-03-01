import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:spotify_clone/redux/reducers.dart';
import 'package:spotify_clone/spotifyapi/getalbum.dart';
import 'package:spotify_clone/spotifyapi/getartists.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';
import 'mainpage2.dart';
import 'model/app_state.dart';
import 'search.dart';
import 'library.dart';
import 'premium.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

Future<void> main() async {
  final _initState = AppState(name: 'Gocool',
      mail: 'gocool7598@gmail.com',
      tracklist: [const Tracks(name: 'name', url: 'https://i.scdn.co/image/ab67616d0000b27326597c053b38c9cf93f8f3a9', artistname: 'artistname')],
      artistlist: [const Artist(name: 'name', url: 'https://i.scdn.co/image/ab6761610000e5eb2dc40ac263ef07c16a95af4e')],
      albumlist: [const Album(name: 'name', url: 'https://i.scdn.co/image/ab67616d0000b27326597c053b38c9cf93f8f3a9', tracks: [])]);
  final Store<AppState> _store = Store<AppState>(reducer,initialState: _initState,middleware: [thunkMiddleware]);
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