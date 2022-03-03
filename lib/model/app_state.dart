import 'package:spotify_clone/model/tracks.dart';
import 'album.dart';
import 'artist.dart';

class AppState{
  late String name;
  late String mail;
  late String image;
  late List<Track> tracklist;
  late List<Artist> artistlist;
  late List<Album> albumlist;
  AppState({required this.name,required this.mail,
    required this.tracklist,required this.artistlist,
    required this.albumlist,required this.image});
  AppState.fromAppState(AppState another)
  {
    image = another.image;
    name = another.name;
    mail = another.mail;
    tracklist = another.tracklist;
    artistlist = another.artistlist;
    albumlist = another.albumlist;
  }
  String get viewname => name;
  String get viewmail => mail;
  String get viewimage => image;
  List<Track> get viewtracklist => tracklist;
  List<Artist> get viewartistlist => artistlist;
  List<Album> get viewalbumlist => albumlist;
}