import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:spotify_clone/model/album.dart';
import 'package:spotify_clone/model/artist.dart';
import 'package:spotify_clone/model/tracks.dart';
import 'package:spotify_clone/redux/reducers.dart';
import 'mainpage.dart';
import '../model/app_state.dart';
import 'search.dart';
import 'library.dart';
import 'premium.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

Future<void> main() async {
  final _initState = AppState(name: 'Gocool',
      mail: 'gocool7598@gmail.com',
      tracklist: [const Track(name: 'name', url: 'https://i.scdn.co/image/ab67616d0000b27326597c053b38c9cf93f8f3a9', artistname: 'artistname')],
      artistlist: [const Artist(name: 'Artist Name', url: 'https://i.scdn.co/image/ab6761610000e5eb2dc40ac263ef07c16a95af4e')],
      albumlist: [const Album(name: 'Album Name', url: 'https://i.scdn.co/image/ab67616d0000b27326597c053b38c9cf93f8f3a9', tracks: [])]);
  final Store<AppState> _store = Store<AppState>(reducer,initialState: _initState,middleware: [thunkMiddleware]);
  runApp(Myapp(store: _store));
}
// void main()=> runApp(const Myapp());

class Myapp extends StatelessWidget {
  final Store<AppState> store;
  const Myapp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return  StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
          // define pt_BR as default when de language code is 'pt'
          if (locale?.languageCode == 'fr') {
            return Locale('fr', 'FR');
          }
          if (locale?.languageCode == 'ta') {
            return Locale('ta', 'IN');
          }
          // default language
          return Locale('en', 'US');
        },
        title: 'Spotify',
        localizationsDelegates: [
          // delegate from flutter_localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // delegate from localization package.
          LocalJsonLocalization.delegate,
        ],
        supportedLocales:const [
          Locale('en','US'),
          Locale('fr','FR'),
        ],
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
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Nav_Home'.i18n(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'Nav_Search'.i18n(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.library_music),
              label: 'Nav_Library'.i18n(),
            ),
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.spotify),
              label: 'Nav_Premium'.i18n(),
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