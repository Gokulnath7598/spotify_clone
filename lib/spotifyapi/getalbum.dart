import 'dart:convert';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/album.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:spotify_clone/redux/actions.dart';

import 'auth.dart';


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


// Future<List<Album>?> fetchAlbum() async {
//   auth();
//   final prefs = await SharedPreferences.getInstance();
//   final String? token1 = prefs.getString('token');
//   String query =
//       "https://api.spotify.com/v1/albums?ids=382ObEPsp2rxGrnsizN5TX,1A2GTWGtFfWp7KSQTwWOyo,2noRn2Aes5aoNVsU6iWThc,4aawyAB9vmqN3uQ7FjRGTy";
//   Map<String, String> headers1 = {
//     "Authorization": "Bearer " + token1!,
//     "Accept": "application/json",
//     "Content-Type": "application/json",
//   };
//   Response response1 = await get(Uri.parse(query), headers: headers1);
//   var parsedJson1 = json.decode(response1.body);
//   // print('----------------');
//   // print(parsedJson1['albums'][0]['tracks']['items'][2]['id']);
//   // print('----------------');
//   try {
//     if (response1.statusCode == 200) {
//       var allItems = jsonDecode(response1.body)['albums'] as List;
//       //var allItems = jsonDecode(response1.body) as List;
//       List<Album> items =
//       allItems.map((tagJson) => Album.fromJson(tagJson)).toList();
//       // print(Items);
//       return items;
//       // return tagObjs[1];
//     }
//   } catch (e) {
//     throw Exception(e);
//   }
// }