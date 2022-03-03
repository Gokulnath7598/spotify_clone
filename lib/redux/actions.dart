import 'package:spotify_clone/model/album.dart';
import 'package:spotify_clone/model/artist.dart';
import 'package:spotify_clone/model/tracks.dart';

class update_name {
  late final String payload;

  update_name(this.payload);
}

class update_tracks {
  late final List<Track> payload;

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

class update_image {
  late final String payload;

  update_image(this.payload);
}
