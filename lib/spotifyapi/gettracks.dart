import 'dart:convert';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:spotify_clone/model/tracks.dart';
import 'package:spotify_clone/redux/actions.dart';

import 'auth.dart';
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
        List<Track> items =
        allItems.map((tagJson) => Track.fromJson(tagJson)).toList();
        store.dispatch(update_tracks(items));
    };
}





// Future<List<Tracks>?> fetchtracks(allItems) async {
//     auth();
//     String ids="";
//     for(int i=0;i<allItems.length;i++)
//     {
//         if(i<50){
//             if(i==allItems.length-1){
//                 ids=ids+allItems[i]['id'];
//             }
//             else
//             {
//                 ids=ids+allItems[i]['id']+",";
//             }
//         }else{
//             break;
//         }
//     }
//     print(ids);
//     //4lteJuSjb9Jt9W1W7PIU2U
//     final prefs = await SharedPreferences.getInstance();
//     final String? token1 = prefs.getString('token');
//     String query =
//     "https://api.spotify.com/v1/tracks?ids="+ids;
//     Map<String, String> headers1 = {
//         "Authorization": "Bearer " + token1!,
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//     };
//     Response response1 = await get(Uri.parse(query), headers: headers1);
//     var parsedJson1 = json.decode(response1.body);
//     //print(parsedJson1['tracks'][2]['artists'][0]['name']);
//     //print(parsedJson1['tracks'][0]['images']);
//
//     try {
//         if (response1.statusCode == 200) {
//             var allItems = jsonDecode(response1.body)['tracks'] as List;
//             //print(allItems[0]);
//             //var allItems = jsonDecode(response1.body) as List;
//             List<Tracks> items =
//             allItems.map((tagJson) => Tracks.fromJson(tagJson)).toList();
//             // print(Items);
//             return items;
//             // return tagObjs[1];
//         }
//     } catch (e) {
//         throw Exception(e);
//     }
// }


