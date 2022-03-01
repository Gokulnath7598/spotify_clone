import 'dart:convert';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:spotify_clone/spotifyapi/auth.dart';
import 'package:spotify_clone/spotifyapi/getalbum.dart';
import 'package:spotify_clone/spotifyapi/getartists.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';

import 'actions.dart';

ThunkAction<AppState> gettracks(List allItems1) {
  return (Store<AppState> store) async {
    auth();
    String ids = "";
    for (int i = 0; i < allItems1.length; i++) {
      if (i < 50) {
        if (i == allItems1.length - 1) {
          ids = ids + allItems1[i]['id'];
        } else {
          ids = ids + allItems1[i]['id'] + ",";
        }
      } else {
        break;
      }
    }
    final prefs = await SharedPreferences.getInstance();
    final String? token1 = prefs.getString('token');
    String query = "https://api.spotify.com/v1/tracks?ids=" + ids;
    Map<String, String> headers1 = {
      "Authorization": "Bearer " + token1!,
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    Response response1 = await get(Uri.parse(query), headers: headers1);
    var allItems = jsonDecode(response1.body)['tracks'] as List;
    List<Tracks> items =
    allItems.map((tagJson) => Tracks.fromJson(tagJson)).toList();
    store.dispatch(update_tracks(items));
  };
}

ThunkAction<AppState> getartist() {
  return (Store<AppState> store) async {
    auth();
    final prefs = await SharedPreferences.getInstance();
    final String? token1 = prefs.getString('token');
    String query =
        "https://api.spotify.com/v1/artists?ids=0TnOYISbd1XYRBk9myaseg,2CIMQHirSU0MQqyYHq0eOx,57dN52uHvrHOxijzpIgu3E,1vCWHaC5f2uS3yhpwWbIA6";
    Map<String, String> headers1 = {
      "Authorization": "Bearer " + token1!,
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    Response response1 = await get(Uri.parse(query), headers: headers1);
    var allItems = jsonDecode(response1.body)['artists'] as List;
    List<Artist> items =
    allItems.map((tagJson) => Artist.fromJson(tagJson)).toList();
    store.dispatch(update_artist(items));
  };
}


ThunkAction<AppState> getalbum() {
  return (Store<AppState> store) async {
    auth();
    final prefs = await SharedPreferences.getInstance();
    final String? token1 = prefs.getString('token');
    String query =
        "https://api.spotify.com/v1/albums?ids=382ObEPsp2rxGrnsizN5TX,1A2GTWGtFfWp7KSQTwWOyo,2noRn2Aes5aoNVsU6iWThc,4aawyAB9vmqN3uQ7FjRGTy";
    Map<String, String> headers1 = {
      "Authorization": "Bearer " + token1!,
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    Response response1 = await get(Uri.parse(query), headers: headers1);
    var allItems = jsonDecode(response1.body)['albums'] as List;
    List<Album> items =
    allItems.map((tagJson) => Album.fromJson(tagJson)).toList();
    store.dispatch(update_album(items));
  };
}