
import 'dart:convert';

import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/spotifyapi/auth.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';
class update_name{
  late final String payload;
  update_name(this.payload);
}
class update_tracks{
  late final List<Tracks> payload;
  update_tracks(this.payload);
}

ThunkAction<AppState> getval(List allItems1){
  return(Store<AppState> store) async{
    auth();
    String ids="";
    for(int i=0;i<allItems1.length;i++)
    {
      if(i<50){
        if(i==allItems1.length-1){
          ids=ids+allItems1[i]['id'];
        }
        else
        {
          ids=ids+allItems1[i]['id']+",";
        }
      }else{
        break;
      }
    }
    final prefs = await SharedPreferences.getInstance();
    final String? token1 = prefs.getString('token');
    String query =
        "https://api.spotify.com/v1/tracks?ids="+ids;
    Map<String, String> headers1 = {
      "Authorization": "Bearer " + token1!,
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    Response response1 = await get(Uri.parse(query), headers: headers1);
    var parsedJson1 = json.decode(response1.body);
    var allItems = jsonDecode(response1.body)['tracks'] as List;
    List<Tracks> items =
    allItems.map((tagJson) => Tracks.fromJson(tagJson)).toList();
    //print(items[0].url);
    store.dispatch(update_tracks(items));
  };
}