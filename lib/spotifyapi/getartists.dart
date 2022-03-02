import 'dart:convert';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:spotify_clone/model/artist.dart';
import 'package:spotify_clone/redux/actions.dart';
import 'auth.dart';

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


// Future<List<Artist>?> fetchArtists() async {
//   auth();
//   final prefs = await SharedPreferences.getInstance();
//   final String? token1 = prefs.getString('token');
//   String query =
//       "https://api.spotify.com/v1/artists?ids=0TnOYISbd1XYRBk9myaseg,2CIMQHirSU0MQqyYHq0eOx,57dN52uHvrHOxijzpIgu3E,1vCWHaC5f2uS3yhpwWbIA6";
//   Map<String, String> headers1 = {
//     "Authorization": "Bearer " + token1!,
//     "Accept": "application/json",
//     "Content-Type": "application/json",
//   };
//   Response response1 = await get(Uri.parse(query), headers: headers1);
//   var parsedJson1 = json.decode(response1.body);
//   //print(parsedJson1['artists'][0]);
//
//   try {
//     if (response1.statusCode == 200) {
//       var allItems = jsonDecode(response1.body)['artists'] as List;
//       //var allItems = jsonDecode(response1.body) as List;
//       List<Artist> items =
//       allItems.map((tagJson) => Artist.fromJson(tagJson)).toList();
//       // print(Items);
//       return items;
//       // return tagObjs[1];
//     }
//   } catch (e) {
//     throw Exception(e);
//   }
// }
