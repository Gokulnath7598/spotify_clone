import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';

Future<List<Tracks>?> fetchtracks(allItems) async {
    auth();
    String ids="";
    for(int i=0;i<allItems.length;i++)
    {
        if(i<50){
            if(i==allItems.length-1){
                ids=ids+allItems[i]['id'];
            }
            else
            {
                ids=ids+allItems[i]['id']+",";
            }
        }else{
            break;
        }
    }
    print(ids);
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
    //print(parsedJson1['tracks'][2]['artists'][0]['name']);
    //print(parsedJson1['tracks'][0]['images']);

    try {
        if (response1.statusCode == 200) {
            var allItems = jsonDecode(response1.body)['tracks'] as List;
            //print(allItems[0]);
            //var allItems = jsonDecode(response1.body) as List;
            List<Tracks> items =
            allItems.map((tagJson) => Tracks.fromJson(tagJson)).toList();
            // print(Items);
            return items;
            // return tagObjs[1];
        }
    } catch (e) {
        throw Exception(e);
    }
}


class Tracks
{
    final String name;
    final String url;
    final String artistname;

    const Tracks({
        required this.name,
        required this.url,
        required this.artistname,
    });

    factory Tracks.fromJson(Map<String, dynamic> json) {
        return Tracks(
            name: json['name'] as String,
            url: json['album']['images'][0]['url'] as String,
            artistname: json['album']['artists'][0]['name'] as String,
        );
    }
}