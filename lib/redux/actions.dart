
import 'package:spotify_clone/spotifyapi/getalbum.dart';
import 'package:spotify_clone/spotifyapi/getartists.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';

class update_name {
  late final String payload;

  update_name(this.payload);
}

class update_tracks {
  late final List<Tracks> payload;

  update_tracks(this.payload);
}

class update_artist {
  late final List<Artist> payload;

  update_artist(this.payload);
}

class update_album {
  late final List<Album> payload;

  update_album(this.payload);
}


