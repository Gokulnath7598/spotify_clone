
import 'package:spotify_clone/spotifyapi/getalbum.dart';
import 'package:spotify_clone/spotifyapi/getartists.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';

class AppState{
  late String name;
  late String mail;
  late List<Tracks> tracklist;
  late List<Artist> artistlist;
  late List<Album> albumlist;
  AppState({required this.name,required this.mail,required this.tracklist,required this.artistlist,required this.albumlist});
  AppState.fromAppState(AppState another)
  {
    name = another.name;
    mail = another.mail;
    tracklist = another.tracklist;
    artistlist = another.artistlist;
    albumlist = another.albumlist;
  }
  String get viewname => name;
  String get viewmail => mail;
  List<Tracks> get viewtracklist => tracklist;
  List<Artist> get viewartistlist => artistlist;
  List<Album> get viewalbumlist => albumlist;
}