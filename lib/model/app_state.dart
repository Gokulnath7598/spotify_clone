
import 'package:spotify_clone/spotifyapi/gettracks.dart';

class AppState{
  late String name;
  late String mail;
  late List<Tracks> tracklist;
  AppState({required this.name,required this.mail,required this.tracklist});
  AppState.fromAppState(AppState another)
  {
    name = another.name;
    mail = another.mail;
    tracklist = another.tracklist;
  }
  String get viewname => name;
  String get viewmail => mail;
  List<Tracks> get viewtracklist => tracklist;
}