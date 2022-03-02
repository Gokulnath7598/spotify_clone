class Album {
  final String name;
  final String url;
  final List tracks;

  const Album({
    required this.name,
    required this.url,
    required this.tracks,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        name: json['name'] as String,
        url: json['images'][0]['url'] as String,
        tracks: json['tracks']['items'] as List);
  }
}