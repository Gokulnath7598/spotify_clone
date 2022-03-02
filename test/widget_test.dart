// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:spotify_clone/Pages/main.dart';
import 'package:spotify_clone/model/album.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:spotify_clone/model/artist.dart';
import 'package:spotify_clone/model/tracks.dart';
import 'package:spotify_clone/redux/reducers.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final _initState = AppState(name: 'Gocool',
        mail: 'gocool7598@gmail.com',
        tracklist: [const Track(name: 'name', url: 'https://i.scdn.co/image/ab67616d0000b27326597c053b38c9cf93f8f3a9', artistname: 'artistname')],
        artistlist: [const Artist(name: 'name', url: 'https://i.scdn.co/image/ab6761610000e5eb2dc40ac263ef07c16a95af4e')],
        albumlist: [const Album(name: 'name', url: 'https://i.scdn.co/image/ab67616d0000b27326597c053b38c9cf93f8f3a9', tracks: [])]);
    final Store<AppState> _store = Store<AppState>(reducer,initialState: _initState,middleware: [thunkMiddleware]);
    // Build our app and trigger a frame.
    await tester.pumpWidget(Myapp(store: _store));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
